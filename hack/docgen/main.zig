//! Reference documentation extractor for the AWS SDK for Zig.
//!
//! Reads the generated service code under `service/<name>/` and the runtime
//! library under `src/`, and writes Markdown for the cloudboss MkDocs theme:
//! one page per service operation, one page per runtime module, the section
//! indexes, and a literate-nav SUMMARY.

const std = @import("std");
const Ast = std.zig.Ast;
const testing = std.testing;

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;
    const argv = try init.minimal.args.toSlice(allocator);
    defer allocator.free(argv);

    var service_dir: []const u8 = "service";
    var src_dir: []const u8 = "src";
    var out_dir: []const u8 = "docs/reference";
    var services: std.ArrayList([]const u8) = .empty;
    defer services.deinit(allocator);
    var runtime_modules: std.ArrayList([]const u8) = .empty;
    defer runtime_modules.deinit(allocator);
    var runtime_root: ?[]const u8 = null;
    var all_services = false;

    var i: usize = 1;
    while (i < argv.len) : (i += 1) {
        const arg = argv[i];
        if (std.mem.eql(u8, arg, "--service-dir")) {
            i += 1;
            if (i >= argv.len) fatal("--service-dir needs a value", .{});
            service_dir = argv[i];
        } else if (std.mem.eql(u8, arg, "--out")) {
            i += 1;
            if (i >= argv.len) fatal("--out needs a value", .{});
            out_dir = argv[i];
        } else if (std.mem.eql(u8, arg, "--src-dir")) {
            i += 1;
            if (i >= argv.len) fatal("--src-dir needs a value", .{});
            src_dir = argv[i];
        } else if (std.mem.eql(u8, arg, "--runtime")) {
            i += 1;
            if (i >= argv.len) fatal("--runtime needs a value", .{});
            try runtime_modules.append(allocator, argv[i]);
        } else if (std.mem.eql(u8, arg, "--runtime-root")) {
            i += 1;
            if (i >= argv.len) fatal("--runtime-root needs a value", .{});
            runtime_root = argv[i];
        } else if (std.mem.eql(u8, arg, "--all-services")) {
            all_services = true;
        } else {
            try services.append(allocator, arg);
        }
    }

    if (services.items.len == 0 and runtime_modules.items.len == 0 and
        runtime_root == null and !all_services)
        fatal("nothing to do; pass service names, --all-services, " ++
            "--runtime modules, or --runtime-root", .{});

    const io = init.io;
    const cwd: std.Io.Dir = .cwd();
    try cwd.createDirPath(io, out_dir);

    var services_arena = std.heap.ArenaAllocator.init(allocator);
    defer services_arena.deinit();
    if (all_services)
        discoverServices(
            services_arena.allocator(),
            allocator,
            io,
            cwd,
            service_dir,
            &services,
        ) catch |err| {
            fatal("discovering services in {s}: {s}", .{ service_dir, @errorName(err) });
        };

    var summary: std.ArrayList(u8) = .empty;
    defer summary.deinit(allocator);

    var runtime_count: usize = 0;
    if (runtime_root != null or runtime_modules.items.len != 0) {
        runtime_count = generateRuntime(
            allocator,
            io,
            cwd,
            src_dir,
            out_dir,
            runtime_root,
            runtime_modules.items,
            &summary,
        ) catch |err| {
            fatal("runtime: {s}", .{@errorName(err)});
        };
    }

    for (services.items) |service| {
        generateService(allocator, io, cwd, service_dir, out_dir, service, &summary) catch |err| {
            fatal("service {s}: {s}", .{ service, @errorName(err) });
        };
    }

    try writeFilePath(io, cwd, allocator, out_dir, "SUMMARY.md", summary.items);
    std.debug.print(
        "docgen: wrote reference for {d} runtime module(s) and {d} service(s) to {s}\n",
        .{ runtime_count, services.items.len, out_dir },
    );
}

const Operation = struct {
    name: []const u8,
    slug: []const u8,
    signature: []const u8,
    doc: []const u8,
    input: ?[]const u8,
    output: ?[]const u8,
    input_file: ?[]const u8,
};

/// A function's signature without its body: the declaration source from the
/// `pub`/`fn` keyword through the end of the return type. Reads the parsed
/// prototype so a brace in the return type (an `error{...}` set, an anonymous
/// container) is kept rather than mistaken for the body, and signatures that
/// wrap across several lines stay intact.
fn fnSignature(tree: Ast, node: Ast.Node.Index) []const u8 {
    var buf: [1]Ast.Node.Index = undefined;
    const fp = tree.fullFnProto(&buf, node) orelse return "";
    const start = tree.tokenStart(fp.firstToken());
    const ret = fp.ast.return_type.unwrap() orelse
        return std.mem.trimEnd(u8, tree.getNodeSource(node), " \t\r\n{");
    const last = tree.lastToken(ret);
    const end = tree.tokenStart(last) + @as(u32, @intCast(tree.tokenSlice(last).len));
    return std.mem.trimEnd(u8, tree.source[start..end], " \t\r\n");
}

fn generateService(
    gpa: std.mem.Allocator,
    io: std.Io,
    cwd: std.Io.Dir,
    service_dir: []const u8,
    out_dir: []const u8,
    service: []const u8,
    summary: *std.ArrayList(u8),
) !void {
    var arena_state = std.heap.ArenaAllocator.init(gpa);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    const client_path = try std.fmt.allocPrint(
        arena,
        "{s}/{s}/client.zig",
        .{ service_dir, service },
    );
    const client_src = try readFileZ(arena, io, cwd, client_path);
    const client_tree = try Ast.parse(arena, client_src, .zig);

    var imports: std.StringHashMapUnmanaged([]const u8) = .empty;
    try collectImports(arena, &imports, client_tree);

    const client_node = findDecl(client_tree, "Client") orelse return error.NoClientStruct;
    const client_init = client_tree.fullVarDecl(client_node).?.ast.init_node.unwrap() orelse
        return error.NoClientStruct;
    var cbuf: [2]Ast.Node.Index = undefined;
    const client_decl = client_tree.fullContainerDecl(&cbuf, client_init) orelse
        return error.NoClientStruct;

    var title: []const u8 = service;
    var ops: std.ArrayList(Operation) = .empty;

    for (client_decl.ast.members) |m| {
        // Service title comes from `pub const sdk_id = "...";`.
        if (client_tree.fullVarDecl(m)) |vd| {
            const vname = client_tree.tokenSlice(vd.ast.mut_token + 1);
            if (std.mem.eql(u8, vname, "sdk_id")) {
                if (vd.ast.init_node.unwrap()) |sn| {
                    title = std.mem.trim(u8, client_tree.getNodeSource(sn), "\"");
                }
            }
            continue;
        }

        var fbuf: [1]Ast.Node.Index = undefined;
        const fp = client_tree.fullFnProto(&fbuf, m) orelse continue;
        if (fp.visib_token == null) continue;
        const ntok = fp.name_token orelse continue;
        const name = client_tree.tokenSlice(ntok);
        if (isInfrastructureFn(name)) continue;

        const signature = fnSignature(client_tree, m);
        const refs = parseSignature(signature);

        try ops.append(arena, .{
            .name = name,
            // One page per method, named for the method itself. A presigning
            // variant shares its input file with the base operation, so keying
            // the page on the operation name keeps them from colliding.
            .slug = try camelToSnake(arena, name),
            .signature = signature,
            .doc = try reflow(arena, try docLines(arena, client_tree, m)),
            .input = refs.input_type,
            .output = refs.output_type,
            .input_file = refs.input_file,
        });
    }

    for (ops.items) |op| {
        const page = try renderOperation(arena, io, cwd, service_dir, service, &imports, op);
        const rel = try std.fmt.allocPrint(arena, "{s}/{s}.md", .{ service, op.slug });
        try writeFilePath(io, cwd, gpa, out_dir, rel, page);
    }

    const index = try renderServiceIndex(arena, title, service, ops.items);
    const index_rel = try std.fmt.allocPrint(arena, "{s}/index.md", .{service});
    try writeFilePath(io, cwd, gpa, out_dir, index_rel, index);

    try appendf(summary, gpa, "* [{s}]({s}/index.md)\n", .{ title, service });
    for (ops.items) |op| {
        try appendf(summary, gpa, "    * [{s}]({s}/{s}.md)\n", .{ op.name, service, op.slug });
    }
}

fn isInfrastructureFn(name: []const u8) bool {
    const skip = [_][]const u8{ "init", "deinit", "initWithOptions" };
    for (skip) |s| if (std.mem.eql(u8, name, s)) return true;
    return false;
}

const SignatureRefs = struct {
    input_type: ?[]const u8 = null,
    output_type: ?[]const u8 = null,
    input_file: ?[]const u8 = null,
};

/// Pull the input/output type references out of an operation signature line such
/// as `pub fn assumeRole(self: *Self, allocator: ..., input:
/// assume_role.AssumeRoleInput, options: CallOptions) !assume_role.AssumeRoleOutput`.
fn parseSignature(sig: []const u8) SignatureRefs {
    var refs: SignatureRefs = .{};

    if (std.mem.indexOf(u8, sig, "input: ")) |idx| {
        const rest = sig[idx + "input: ".len ..];
        const end = std.mem.indexOfAny(u8, rest, ",)") orelse rest.len;
        const qualified = std.mem.trim(u8, rest[0..end], " ");
        if (std.mem.lastIndexOfScalar(u8, qualified, '.')) |dot| {
            refs.input_file = qualified[0..dot];
            refs.input_type = qualified[dot + 1 ..];
        } else {
            refs.input_type = qualified;
        }
    }

    if (std.mem.lastIndexOfScalar(u8, sig, ')')) |close| {
        var ret = std.mem.trim(u8, sig[close + 1 ..], " ");
        ret = std.mem.trimStart(u8, ret, "!");
        // The signature line keeps the opening body brace; the return type ends
        // at the first whitespace or '{'.
        ret = ret[0 .. std.mem.indexOfAny(u8, ret, " {") orelse ret.len];
        if (ret.len != 0 and ret[0] != '[' and !std.mem.eql(u8, ret, "void")) {
            if (std.mem.lastIndexOfScalar(u8, ret, '.')) |dot| {
                refs.output_type = ret[dot + 1 ..];
            } else {
                refs.output_type = ret;
            }
        }
    }

    return refs;
}

fn renderOperation(
    arena: std.mem.Allocator,
    io: std.Io,
    cwd: std.Io.Dir,
    service_dir: []const u8,
    service: []const u8,
    imports: *std.StringHashMapUnmanaged([]const u8),
    op: Operation,
) ![]u8 {
    var page: std.ArrayList(u8) = .empty;
    try appendf(&page, arena, "# {s}\n\n", .{op.name});
    try appendf(&page, arena, "```zig\n{s}\n```\n\n", .{op.signature});
    if (op.doc.len != 0) try appendf(&page, arena, "{s}\n\n", .{op.doc});

    if (op.input_file) |alias| {
        const stem = imports.get(alias) orelse alias;
        const path = try std.fmt.allocPrint(
            arena,
            "{s}/{s}/{s}.zig",
            .{ service_dir, service, stem },
        );
        if (readFileZ(arena, io, cwd, path)) |src| {
            const tree = try Ast.parse(arena, src, .zig);
            if (op.input) |t| try renderStruct(arena, &page, tree, t, "Input");
            if (op.output) |t| try renderStruct(arena, &page, tree, t, "Output");
        } else |_| {}
    }

    return page.items;
}

fn renderStruct(
    arena: std.mem.Allocator,
    page: *std.ArrayList(u8),
    tree: Ast,
    type_name: []const u8,
    label: []const u8,
) !void {
    const node = findDecl(tree, type_name) orelse return;
    const init_node = tree.fullVarDecl(node).?.ast.init_node.unwrap() orelse return;
    var buf: [2]Ast.Node.Index = undefined;
    const decl = tree.fullContainerDecl(&buf, init_node) orelse return;

    try appendf(page, arena, "## {s}: `{s}`\n\n", .{ label, type_name });

    var any = false;
    for (decl.ast.members) |m| {
        const field = tree.fullContainerField(m) orelse continue;
        const type_expr = field.ast.type_expr.unwrap() orelse continue;
        any = true;
        const fname = tree.tokenSlice(field.ast.main_token);
        const ftype = tree.getNodeSource(type_expr);
        const optional = ftype.len != 0 and ftype[0] == '?';
        try appendf(page, arena, "### `{s}`\n\n", .{fname});
        try appendf(page, arena, "Type: `{s}`{s}\n\n", .{
            ftype,
            if (optional) " (optional)" else "",
        });
        const doc = try reflow(arena, try docLines(arena, tree, m));
        if (doc.len != 0) try appendf(page, arena, "{s}\n\n", .{doc});
    }
    if (!any) try page.appendSlice(arena, "_No fields._\n\n");
}

fn renderServiceIndex(
    arena: std.mem.Allocator,
    title: []const u8,
    service: []const u8,
    ops: []const Operation,
) ![]u8 {
    var page: std.ArrayList(u8) = .empty;
    try appendf(&page, arena, "# {s}\n\n", .{title});
    try appendf(&page, arena, "Client module: `{s}`.\n\n", .{service});
    try page.appendSlice(arena, "## Operations\n\n");
    for (ops) |op| {
        try appendf(&page, arena, "- [{s}]({s}.md)\n", .{ op.name, op.slug });
    }
    return page.items;
}

const RuntimeModule = struct {
    /// Public name the runtime exposes, e.g. `process_creds`.
    name: []const u8,
    /// File stem under the source directory, e.g. `process`.
    stem: []const u8,
};

fn generateRuntime(
    gpa: std.mem.Allocator,
    io: std.Io,
    cwd: std.Io.Dir,
    src_dir: []const u8,
    out_dir: []const u8,
    root_file: ?[]const u8,
    explicit: []const []const u8,
    summary: *std.ArrayList(u8),
) !usize {
    var arena_state = std.heap.ArenaAllocator.init(gpa);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    var modules: std.ArrayList(RuntimeModule) = .empty;
    if (root_file) |rf| try discoverModules(arena, io, cwd, rf, &modules);
    for (explicit) |name| try modules.append(arena, .{ .name = name, .stem = name });

    try summary.appendSlice(gpa, "* [Runtime](runtime/index.md)\n");

    var index: std.ArrayList(u8) = .empty;
    defer index.deinit(gpa);
    try index.appendSlice(gpa, "# Runtime\n\nThe `aws` runtime module.\n\n## Modules\n\n");

    for (modules.items) |module| {
        var page_arena = std.heap.ArenaAllocator.init(gpa);
        defer page_arena.deinit();
        const pa = page_arena.allocator();

        const path = try std.fmt.allocPrint(pa, "{s}/{s}.zig", .{ src_dir, module.stem });
        const src = try readFileZ(pa, io, cwd, path);
        const tree = try Ast.parse(pa, src, .zig);
        const page = try renderModule(pa, tree, module.name);

        const rel = try std.fmt.allocPrint(pa, "runtime/{s}.md", .{module.name});
        try writeFilePath(io, cwd, gpa, out_dir, rel, page);

        try appendf(summary, gpa, "    * [{s}](runtime/{s}.md)\n", .{ module.name, module.name });
        try appendf(&index, gpa, "- [{s}]({s}.md)\n", .{ module.name, module.name });
    }

    try writeFilePath(io, cwd, gpa, out_dir, "runtime/index.md", index.items);
    return modules.items.len;
}

/// Append every service under `service_dir` that has a `client.zig`. Names are
/// sorted so the generated SUMMARY and pages stay stable regardless of the order
/// the filesystem reports directory entries in. The duped names are owned by
/// `arena`; the list itself grows with `list_alloc`.
fn discoverServices(
    arena: std.mem.Allocator,
    list_alloc: std.mem.Allocator,
    io: std.Io,
    cwd: std.Io.Dir,
    service_dir: []const u8,
    out: *std.ArrayList([]const u8),
) !void {
    const start = out.items.len;
    var dir = try cwd.openDir(io, service_dir, .{ .iterate = true });
    defer dir.close(io);
    var it = dir.iterate();
    while (try it.next(io)) |entry| {
        if (entry.kind != .directory) continue;
        const client = try std.fmt.allocPrint(
            arena,
            "{s}/{s}/client.zig",
            .{ service_dir, entry.name },
        );
        cwd.access(io, client, .{}) catch continue;
        try out.append(list_alloc, try arena.dupe(u8, entry.name));
    }
    std.mem.sort([]const u8, out.items[start..], {}, lessThanName);
}

fn lessThanName(_: void, a: []const u8, b: []const u8) bool {
    return std.mem.lessThan(u8, a, b);
}

/// Collect the public module namespaces a runtime root re-exports: every
/// `pub const <name> = @import("<stem>.zig");` declaration in the file.
fn discoverModules(
    arena: std.mem.Allocator,
    io: std.Io,
    cwd: std.Io.Dir,
    root_file: []const u8,
    out: *std.ArrayList(RuntimeModule),
) !void {
    const src = try readFileZ(arena, io, cwd, root_file);
    const tree = try Ast.parse(arena, src, .zig);
    for (tree.rootDecls()) |node| {
        const vd = tree.fullVarDecl(node) orelse continue;
        if (vd.visib_token == null) continue;
        const init_node = vd.ast.init_node.unwrap() orelse continue;
        const stem = importStem(tree.getNodeSource(init_node)) orelse continue;
        try out.append(arena, .{
            .name = tree.tokenSlice(vd.ast.mut_token + 1),
            .stem = stem,
        });
    }
}

/// The file stem of an `@import("<stem>.zig")` expression, or null when the
/// source is not such an import.
fn importStem(src: []const u8) ?[]const u8 {
    const marker = "@import(\"";
    const at = std.mem.indexOf(u8, src, marker) orelse return null;
    const rest = src[at + marker.len ..];
    const end = std.mem.indexOfScalar(u8, rest, '"') orelse return null;
    const file = rest[0..end];
    if (!std.mem.endsWith(u8, file, ".zig")) return null;
    return file[0 .. file.len - ".zig".len];
}

fn renderModule(arena: std.mem.Allocator, tree: Ast, module: []const u8) ![]u8 {
    var page: std.ArrayList(u8) = .empty;
    try appendf(&page, arena, "# {s}\n\n", .{module});

    const mod_doc = try reflow(arena, try moduleDocLines(arena, tree));
    if (mod_doc.len != 0) try appendf(&page, arena, "{s}\n\n", .{mod_doc});

    var fbuf: [1]Ast.Node.Index = undefined;
    for (tree.rootDecls()) |node| {
        if (tree.fullFnProto(&fbuf, node)) |fp| {
            if (fp.visib_token == null) continue;
            const name = tree.tokenSlice(fp.name_token orelse continue);
            try renderFunction(arena, &page, tree, node, name, "##");
        } else if (tree.fullVarDecl(node)) |vd| {
            if (vd.visib_token == null) continue;
            try renderDecl(arena, &page, tree, node, vd);
        }
    }
    return page.items;
}

/// A public type, function, or value declared at a module's top level. A struct,
/// enum, or union is rendered with its fields or variants and its public
/// methods; anything else (an alias, a constant, an error set) shows its source.
fn renderDecl(
    arena: std.mem.Allocator,
    page: *std.ArrayList(u8),
    tree: Ast,
    node: Ast.Node.Index,
    vd: Ast.full.VarDecl,
) !void {
    const name = tree.tokenSlice(vd.ast.mut_token + 1);
    const init_node = vd.ast.init_node.unwrap() orelse return;
    var cbuf: [2]Ast.Node.Index = undefined;
    if (tree.fullContainerDecl(&cbuf, init_node)) |container| {
        try renderType(arena, page, tree, node, name, container);
        return;
    }

    try appendf(page, arena, "## `{s}`\n\n", .{name});
    try appendf(page, arena, "```zig\n{s}\n```\n\n", .{tree.getNodeSource(node)});
    const doc = try reflow(arena, try docLines(arena, tree, node));
    if (doc.len != 0) try appendf(page, arena, "{s}\n\n", .{doc});
}

fn renderType(
    arena: std.mem.Allocator,
    page: *std.ArrayList(u8),
    tree: Ast,
    node: Ast.Node.Index,
    name: []const u8,
    container: Ast.full.ContainerDecl,
) !void {
    try appendf(page, arena, "## `{s}`\n\n", .{name});
    const doc = try reflow(arena, try docLines(arena, tree, node));
    if (doc.len != 0) try appendf(page, arena, "{s}\n\n", .{doc});

    for (container.ast.members) |m| {
        const field = tree.fullContainerField(m) orelse continue;
        const fname = tree.tokenSlice(field.ast.main_token);
        try appendf(page, arena, "### `{s}`\n\n", .{fname});
        // A named struct or union field has a type; a bare enum variant is
        // tuple-like and its main token is the variant name, not a type.
        if (!field.ast.tuple_like) {
            if (field.ast.type_expr.unwrap()) |type_expr| {
                const ftype = tree.getNodeSource(type_expr);
                const optional = ftype.len != 0 and ftype[0] == '?';
                try appendf(page, arena, "Type: `{s}`{s}\n\n", .{
                    ftype,
                    if (optional) " (optional)" else "",
                });
            }
        }
        const fdoc = try reflow(arena, try docLines(arena, tree, m));
        if (fdoc.len != 0) try appendf(page, arena, "{s}\n\n", .{fdoc});
    }

    var fbuf: [1]Ast.Node.Index = undefined;
    for (container.ast.members) |m| {
        const fp = tree.fullFnProto(&fbuf, m) orelse continue;
        if (fp.visib_token == null) continue;
        const mname = tree.tokenSlice(fp.name_token orelse continue);
        try renderFunction(arena, page, tree, m, mname, "###");
    }
}

fn renderFunction(
    arena: std.mem.Allocator,
    page: *std.ArrayList(u8),
    tree: Ast,
    node: Ast.Node.Index,
    name: []const u8,
    heading: []const u8,
) !void {
    try appendf(page, arena, "{s} `{s}`\n\n", .{ heading, name });
    try appendf(page, arena, "```zig\n{s}\n```\n\n", .{fnSignature(tree, node)});
    const doc = try reflow(arena, try docLines(arena, tree, node));
    if (doc.len != 0) try appendf(page, arena, "{s}\n\n", .{doc});
}

/// The `//!` module doc comment lines at the top of a file, `//!` stripped.
fn moduleDocLines(arena: std.mem.Allocator, tree: Ast) ![]const []const u8 {
    const tags = tree.tokens.items(.tag);
    var lines: std.ArrayList([]const u8) = .empty;
    var t: u32 = 0;
    while (t < tags.len and tags[t] == .container_doc_comment) : (t += 1) {
        const slice = tree.tokenSlice(t);
        const body = std.mem.trimStart(u8, slice[3..], " ");
        try lines.append(arena, std.mem.trimEnd(u8, body, " \r"));
    }
    return lines.items;
}

fn findDecl(tree: Ast, name: []const u8) ?Ast.Node.Index {
    for (tree.rootDecls()) |node| {
        const vd = tree.fullVarDecl(node) orelse continue;
        if (std.mem.eql(u8, tree.tokenSlice(vd.ast.mut_token + 1), name)) return node;
    }
    return null;
}

fn collectImports(
    allocator: std.mem.Allocator,
    imports: *std.StringHashMapUnmanaged([]const u8),
    tree: Ast,
) !void {
    for (tree.rootDecls()) |node| {
        const vd = tree.fullVarDecl(node) orelse continue;
        const init_node = vd.ast.init_node.unwrap() orelse continue;
        const stem = importStem(tree.getNodeSource(init_node)) orelse continue;
        try imports.put(allocator, tree.tokenSlice(vd.ast.mut_token + 1), stem);
    }
}

/// Doc comment lines attached to a node, with the `///` prefix stripped. Works
/// whether the node's first token is the doc comment (container fields) or the
/// doc comment precedes it (functions, var decls). Slices point into the tree
/// source and are valid for the lifetime of the tree.
fn docLines(arena: std.mem.Allocator, tree: Ast, node: Ast.Node.Index) ![]const []const u8 {
    const tags = tree.tokens.items(.tag);
    var lo = tree.firstToken(node);
    while (lo > 0 and tags[lo - 1] == .doc_comment) lo -= 1;

    var lines: std.ArrayList([]const u8) = .empty;
    var t = lo;
    while (t < tags.len and tags[t] == .doc_comment) : (t += 1) {
        // tokenSlice keeps the leading "///"; drop it.
        const slice = tree.tokenSlice(t);
        const body = std.mem.trimStart(u8, slice[3..], " ");
        try lines.append(arena, std.mem.trimEnd(u8, body, " \r"));
    }
    return lines.items;
}

fn isListItem(line: []const u8) bool {
    const t = std.mem.trimStart(u8, line, " ");
    if (std.mem.startsWith(u8, t, "* ") or std.mem.startsWith(u8, t, "- ")) return true;
    var i: usize = 0;
    while (i < t.len and std.ascii.isDigit(t[i])) i += 1;
    return i > 0 and i + 1 < t.len and t[i] == '.' and t[i + 1] == ' ';
}

fn isFence(line: []const u8) bool {
    return std.mem.startsWith(u8, std.mem.trimStart(u8, line, " "), "```");
}

/// Re-flow 76-column hard-wrapped doc lines into Markdown: join wrapped lines
/// within a block into one logical line, keep blank lines as paragraph breaks,
/// keep list items on their own line, and pass code fences through verbatim.
fn reflow(arena: std.mem.Allocator, lines: []const []const u8) ![]u8 {
    var out: std.ArrayList(u8) = .empty;
    var cur: std.ArrayList(u8) = .empty;
    defer cur.deinit(arena);
    var in_code = false;
    var blank_pending = false;

    for (lines) |line| {
        if (in_code) {
            try writeLogical(arena, &out, line, &blank_pending);
            if (isFence(line)) in_code = false;
            continue;
        }
        if (isFence(line)) {
            try flushPara(arena, &out, &cur, &blank_pending);
            try writeLogical(arena, &out, line, &blank_pending);
            in_code = true;
            continue;
        }
        if (line.len == 0) {
            try flushPara(arena, &out, &cur, &blank_pending);
            blank_pending = true;
            continue;
        }
        if (isListItem(line)) {
            try flushPara(arena, &out, &cur, &blank_pending);
            try cur.appendSlice(arena, std.mem.trimEnd(u8, line, " "));
        } else if (std.mem.startsWith(u8, line, "  ") and cur.items.len != 0) {
            try cur.append(arena, ' ');
            try cur.appendSlice(arena, std.mem.trim(u8, line, " "));
        } else {
            if (cur.items.len != 0) try cur.append(arena, ' ');
            try cur.appendSlice(arena, std.mem.trim(u8, line, " "));
        }
    }
    try flushPara(arena, &out, &cur, &blank_pending);
    return out.toOwnedSlice(arena);
}

/// Emit one logical line, separated from the previous output by a blank line
/// when a paragraph break is pending, otherwise by a single newline.
fn writeLogical(
    arena: std.mem.Allocator,
    out: *std.ArrayList(u8),
    bytes: []const u8,
    blank_pending: *bool,
) !void {
    if (out.items.len != 0) try out.appendSlice(arena, if (blank_pending.*) "\n\n" else "\n");
    blank_pending.* = false;
    try out.appendSlice(arena, bytes);
}

fn flushPara(
    arena: std.mem.Allocator,
    out: *std.ArrayList(u8),
    cur: *std.ArrayList(u8),
    blank_pending: *bool,
) !void {
    if (cur.items.len == 0) return;
    try writeLogical(arena, out, cur.items, blank_pending);
    cur.clearRetainingCapacity();
}

fn camelToSnake(arena: std.mem.Allocator, name: []const u8) ![]u8 {
    var out: std.ArrayList(u8) = .empty;
    for (name, 0..) |c, idx| {
        if (std.ascii.isUpper(c)) {
            if (idx != 0) try out.append(arena, '_');
            try out.append(arena, std.ascii.toLower(c));
        } else {
            try out.append(arena, c);
        }
    }
    return out.toOwnedSlice(arena);
}

fn readFileZ(arena: std.mem.Allocator, io: std.Io, dir: std.Io.Dir, path: []const u8) ![:0]u8 {
    const bytes = try dir.readFileAlloc(io, path, arena, .unlimited);
    return arena.dupeZ(u8, bytes);
}

fn writeFilePath(
    io: std.Io,
    dir: std.Io.Dir,
    gpa: std.mem.Allocator,
    out_dir: []const u8,
    rel: []const u8,
    data: []const u8,
) !void {
    const full = try std.fmt.allocPrint(gpa, "{s}/{s}", .{ out_dir, rel });
    defer gpa.free(full);
    if (std.fs.path.dirname(full)) |parent| try dir.createDirPath(io, parent);
    try dir.writeFile(io, .{ .sub_path = full, .data = data });
}

fn appendf(
    list: *std.ArrayList(u8),
    allocator: std.mem.Allocator,
    comptime fmt: []const u8,
    args: anytype,
) !void {
    const s = try std.fmt.allocPrint(allocator, fmt, args);
    defer allocator.free(s);
    try list.appendSlice(allocator, s);
}

fn fatal(comptime fmt: []const u8, args: anytype) noreturn {
    std.debug.print("docgen: " ++ fmt ++ "\n", args);
    std.process.exit(1);
}

test "reflow joins wrapped lines into a paragraph" {
    const a = testing.allocator;
    const lines = [_][]const u8{
        "The Amazon Resource Name (ARN) of the role to assume. For more",
        "information, see the docs.",
    };
    const md = try reflow(a, &lines);
    defer a.free(md);
    try testing.expectEqualStrings(
        "The Amazon Resource Name (ARN) of the role to assume. For more information, see the docs.",
        md,
    );
}

test "reflow keeps paragraph breaks and list items" {
    const a = testing.allocator;
    const lines = [_][]const u8{
        "Intro paragraph that",
        "wraps once.",
        "",
        "* first item that",
        "  continues on a second line",
        "* second item",
    };
    const md = try reflow(a, &lines);
    defer a.free(md);
    try testing.expectEqualStrings(
        "Intro paragraph that wraps once.\n\n" ++
            "* first item that continues on a second line\n* second item",
        md,
    );
}

test "reflow passes code fences through verbatim" {
    const a = testing.allocator;
    const lines = [_][]const u8{ "Example:", "", "```", "aws s3 ls", "```" };
    const md = try reflow(a, &lines);
    defer a.free(md);
    try testing.expectEqualStrings("Example:\n\n```\naws s3 ls\n```", md);
}

test "parseSignature pulls input and output types" {
    const sig = "pub fn assumeRole(self: *Self, allocator: std.mem.Allocator, " ++
        "input: assume_role.AssumeRoleInput, options: CallOptions) !assume_role.AssumeRoleOutput";
    const refs = parseSignature(sig);
    try testing.expectEqualStrings("assume_role", refs.input_file.?);
    try testing.expectEqualStrings("AssumeRoleInput", refs.input_type.?);
    try testing.expectEqualStrings("AssumeRoleOutput", refs.output_type.?);
}

test "parseSignature handles slice return without an output struct" {
    const sig = "pub fn presignGetCallerIdentity(self: *Self, allocator: std.mem.Allocator, " ++
        "input: get_caller_identity.GetCallerIdentityInput, " ++
        "options: get_caller_identity.PresignOptions) ![]const u8";
    const refs = parseSignature(sig);
    try testing.expectEqualStrings("GetCallerIdentityInput", refs.input_type.?);
    try testing.expect(refs.output_type == null);
}

test "parseSignature ignores the opening body brace on the return type" {
    const sig = "pub fn assumeRole(self: *Self, allocator: std.mem.Allocator, " ++
        "input: assume_role.AssumeRoleInput, options: CallOptions) !assume_role.AssumeRoleOutput {";
    const refs = parseSignature(sig);
    try testing.expectEqualStrings("AssumeRoleOutput", refs.output_type.?);
}

fn parseFirstDecl(arena: std.mem.Allocator, src: []const u8) !struct { Ast, Ast.Node.Index } {
    const tree = try Ast.parse(arena, try arena.dupeZ(u8, src), .zig);
    return .{ tree, tree.rootDecls()[0] };
}

test "fnSignature keeps the full signature and drops the body" {
    var arena_state = std.heap.ArenaAllocator.init(testing.allocator);
    defer arena_state.deinit();
    const tree, const node = try parseFirstDecl(
        arena_state.allocator(),
        "pub fn getObject(self: *Self) !get_object.GetObjectOutput {\n    return foo;\n}\n",
    );
    try testing.expectEqualStrings(
        "pub fn getObject(self: *Self) !get_object.GetObjectOutput",
        fnSignature(tree, node),
    );
}

test "fnSignature keeps a brace in an error-set return type" {
    var arena_state = std.heap.ArenaAllocator.init(testing.allocator);
    defer arena_state.deinit();
    const tree, const node = try parseFirstDecl(
        arena_state.allocator(),
        "pub fn fromString(s: []const u8) error{Bad}!Mode {\n    return .a;\n}\n",
    );
    try testing.expectEqualStrings(
        "pub fn fromString(s: []const u8) error{Bad}!Mode",
        fnSignature(tree, node),
    );
}

test "fnSignature keeps a signature that wraps across lines" {
    var arena_state = std.heap.ArenaAllocator.init(testing.allocator);
    defer arena_state.deinit();
    const tree, const node = try parseFirstDecl(
        arena_state.allocator(),
        "pub fn load(\n" ++
            "    allocator: std.mem.Allocator,\n" ++
            "    options: LoadOptions,\n" ++
            ") !Config {\n    return undefined;\n}\n",
    );
    try testing.expectEqualStrings(
        "pub fn load(\n    allocator: std.mem.Allocator,\n    options: LoadOptions,\n) !Config",
        fnSignature(tree, node),
    );
}

test "camelToSnake matches the operation file stem" {
    const a = testing.allocator;
    const got = try camelToSnake(a, "assumeRoleWithSaml");
    defer a.free(got);
    try testing.expectEqualStrings("assume_role_with_saml", got);
}

test "renderModule documents the module doc, types, variants, and functions" {
    var arena_state = std.heap.ArenaAllocator.init(testing.allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    const raw = "//! Example module.\n" ++
        "const std = @import(\"std\");\n" ++
        "pub const Mode = enum {\n" ++
        "    /// Go fast.\n" ++
        "    fast,\n" ++
        "    slow,\n" ++
        "};\n" ++
        "/// Adds two numbers.\n" ++
        "pub fn add(x: u8, y: u8) u8 {\n" ++
        "    return x + y;\n" ++
        "}\n" ++
        "fn hidden() void {}\n";
    const tree = try Ast.parse(arena, try arena.dupeZ(u8, raw), .zig);
    const page = try renderModule(arena, tree, "example");

    for ([_][]const u8{
        "# example",
        "Example module.",
        "## `Mode`",
        "### `fast`",
        "Go fast.",
        "## `add`",
        "Adds two numbers.",
    }) |needle| {
        try testing.expect(std.mem.indexOf(u8, page, needle) != null);
    }
    // Private declarations are skipped, and a bare enum variant has no type line.
    try testing.expect(std.mem.indexOf(u8, page, "hidden") == null);
    try testing.expect(std.mem.indexOf(u8, page, "Type: `fast`") == null);
}

test "importStem reads the stem of a .zig import" {
    try testing.expectEqualStrings("process", importStem("@import(\"process.zig\")").?);
    try testing.expect(importStem("@import(\"std\")") == null);
    try testing.expect(importStem("config.Config") == null);
}
