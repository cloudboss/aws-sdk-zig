const std = @import("std");

pub const PackageManager = enum {
    bundler,
    cargo,
    composer,
    npm,
    nuget,
    pipenv,
    poetry,
    yarn,
    gobinary,
    gomod,
    jar,
    os,
    pip,
    pythonpkg,
    nodepkg,
    pom,
    gemspec,
    dotnet_core,

    pub const json_field_names = .{
        .bundler = "BUNDLER",
        .cargo = "CARGO",
        .composer = "COMPOSER",
        .npm = "NPM",
        .nuget = "NUGET",
        .pipenv = "PIPENV",
        .poetry = "POETRY",
        .yarn = "YARN",
        .gobinary = "GOBINARY",
        .gomod = "GOMOD",
        .jar = "JAR",
        .os = "OS",
        .pip = "PIP",
        .pythonpkg = "PYTHONPKG",
        .nodepkg = "NODEPKG",
        .pom = "POM",
        .gemspec = "GEMSPEC",
        .dotnet_core = "DOTNET_CORE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bundler => "BUNDLER",
            .cargo => "CARGO",
            .composer => "COMPOSER",
            .npm => "NPM",
            .nuget => "NUGET",
            .pipenv => "PIPENV",
            .poetry => "POETRY",
            .yarn => "YARN",
            .gobinary => "GOBINARY",
            .gomod => "GOMOD",
            .jar => "JAR",
            .os => "OS",
            .pip => "PIP",
            .pythonpkg => "PYTHONPKG",
            .nodepkg => "NODEPKG",
            .pom => "POM",
            .gemspec => "GEMSPEC",
            .dotnet_core => "DOTNET_CORE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
