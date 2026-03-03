const std = @import("std");

pub const Runtime = enum {
    python_3,
    nodejs_12,
    nodejs_14,
    corretto_8,
    corretto_11,
    nodejs_16,
    go_1,
    dotnet_6,
    php_81,
    ruby_31,
    python_311,
    nodejs_18,
    nodejs_22,

    pub const json_field_names = .{
        .python_3 = "PYTHON_3",
        .nodejs_12 = "NODEJS_12",
        .nodejs_14 = "NODEJS_14",
        .corretto_8 = "CORRETTO_8",
        .corretto_11 = "CORRETTO_11",
        .nodejs_16 = "NODEJS_16",
        .go_1 = "GO_1",
        .dotnet_6 = "DOTNET_6",
        .php_81 = "PHP_81",
        .ruby_31 = "RUBY_31",
        .python_311 = "PYTHON_311",
        .nodejs_18 = "NODEJS_18",
        .nodejs_22 = "NODEJS_22",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .python_3 => "PYTHON_3",
            .nodejs_12 => "NODEJS_12",
            .nodejs_14 => "NODEJS_14",
            .corretto_8 => "CORRETTO_8",
            .corretto_11 => "CORRETTO_11",
            .nodejs_16 => "NODEJS_16",
            .go_1 => "GO_1",
            .dotnet_6 => "DOTNET_6",
            .php_81 => "PHP_81",
            .ruby_31 => "RUBY_31",
            .python_311 => "PYTHON_311",
            .nodejs_18 => "NODEJS_18",
            .nodejs_22 => "NODEJS_22",
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
