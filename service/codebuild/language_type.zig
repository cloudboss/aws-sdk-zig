const std = @import("std");

pub const LanguageType = enum {
    java,
    python,
    node_js,
    ruby,
    golang,
    docker,
    android,
    dotnet,
    base,
    php,

    pub const json_field_names = .{
        .java = "JAVA",
        .python = "PYTHON",
        .node_js = "NODE_JS",
        .ruby = "RUBY",
        .golang = "GOLANG",
        .docker = "DOCKER",
        .android = "ANDROID",
        .dotnet = "DOTNET",
        .base = "BASE",
        .php = "PHP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .java => "JAVA",
            .python => "PYTHON",
            .node_js => "NODE_JS",
            .ruby => "RUBY",
            .golang => "GOLANG",
            .docker => "DOCKER",
            .android => "ANDROID",
            .dotnet => "DOTNET",
            .base => "BASE",
            .php => "PHP",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
