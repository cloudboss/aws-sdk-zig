const aws = @import("aws");

const ApiConfiguration = @import("api_configuration.zig").ApiConfiguration;
const JSModule = @import("js_module.zig").JSModule;
const JSScript = @import("js_script.zig").JSScript;
const JSTarget = @import("js_target.zig").JSTarget;

/// Describes the code generation job configuration for a React project.
pub const ReactStartCodegenJobData = struct {
    /// The API configuration for the code generation job.
    api_configuration: ?ApiConfiguration = null,

    /// Lists the dependency packages that may be required for the project code to
    /// run.
    dependencies: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether the code generation job should render inline source maps.
    inline_source_map: bool = false,

    /// The JavaScript module type.
    module: ?JSModule = null,

    /// Specifies whether the code generation job should render type declaration
    /// files.
    render_type_declarations: bool = false,

    /// The file type to use for a JavaScript project.
    script: ?JSScript = null,

    /// The ECMAScript specification to use.
    target: ?JSTarget = null,

    pub const json_field_names = .{
        .api_configuration = "apiConfiguration",
        .dependencies = "dependencies",
        .inline_source_map = "inlineSourceMap",
        .module = "module",
        .render_type_declarations = "renderTypeDeclarations",
        .script = "script",
        .target = "target",
    };
};
