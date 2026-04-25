const std = @import("std");

pub const Runtime = enum {
    nodejs,
    nodejs_12_x,
    nodejs_14_x,
    nodejs_16_x,
    java_8,
    java_8_al2,
    java_11,
    python_3_7,
    python_3_8,
    python_3_9,
    unsupported,
    nodejs_18_x,
    go_1_x,
    java_17,
    python_3_10,
    python_3_11,
    dotnetcore_3_1,
    dotnet_6,
    dotnet_7,
    ruby_2_7,
    ruby_3_2,
    dotnet_10,
    nodejs_24_x,

    pub const json_field_names = .{
        .nodejs = "NODEJS",
        .nodejs_12_x = "NODEJS_12_X",
        .nodejs_14_x = "NODEJS_14_X",
        .nodejs_16_x = "NODEJS_16_X",
        .java_8 = "JAVA_8",
        .java_8_al2 = "JAVA_8_AL2",
        .java_11 = "JAVA_11",
        .python_3_7 = "PYTHON_3_7",
        .python_3_8 = "PYTHON_3_8",
        .python_3_9 = "PYTHON_3_9",
        .unsupported = "UNSUPPORTED",
        .nodejs_18_x = "NODEJS_18_X",
        .go_1_x = "GO_1_X",
        .java_17 = "JAVA_17",
        .python_3_10 = "PYTHON_3_10",
        .python_3_11 = "PYTHON_3_11",
        .dotnetcore_3_1 = "DOTNETCORE_3_1",
        .dotnet_6 = "DOTNET_6",
        .dotnet_7 = "DOTNET_7",
        .ruby_2_7 = "RUBY_2_7",
        .ruby_3_2 = "RUBY_3_2",
        .dotnet_10 = "DOTNET_10",
        .nodejs_24_x = "NODEJS_24_X",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .nodejs => "NODEJS",
            .nodejs_12_x => "NODEJS_12_X",
            .nodejs_14_x => "NODEJS_14_X",
            .nodejs_16_x => "NODEJS_16_X",
            .java_8 => "JAVA_8",
            .java_8_al2 => "JAVA_8_AL2",
            .java_11 => "JAVA_11",
            .python_3_7 => "PYTHON_3_7",
            .python_3_8 => "PYTHON_3_8",
            .python_3_9 => "PYTHON_3_9",
            .unsupported => "UNSUPPORTED",
            .nodejs_18_x => "NODEJS_18_X",
            .go_1_x => "GO_1_X",
            .java_17 => "JAVA_17",
            .python_3_10 => "PYTHON_3_10",
            .python_3_11 => "PYTHON_3_11",
            .dotnetcore_3_1 => "DOTNETCORE_3_1",
            .dotnet_6 => "DOTNET_6",
            .dotnet_7 => "DOTNET_7",
            .ruby_2_7 => "RUBY_2_7",
            .ruby_3_2 => "RUBY_3_2",
            .dotnet_10 => "DOTNET_10",
            .nodejs_24_x => "NODEJS_24_X",
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
