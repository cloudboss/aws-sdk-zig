const std = @import("std");

pub const TargetEntityType = enum {
    domain_unit,
    environment_blueprint_configuration,
    environment_profile,
    asset_type,

    pub const json_field_names = .{
        .domain_unit = "DOMAIN_UNIT",
        .environment_blueprint_configuration = "ENVIRONMENT_BLUEPRINT_CONFIGURATION",
        .environment_profile = "ENVIRONMENT_PROFILE",
        .asset_type = "ASSET_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .domain_unit => "DOMAIN_UNIT",
            .environment_blueprint_configuration => "ENVIRONMENT_BLUEPRINT_CONFIGURATION",
            .environment_profile => "ENVIRONMENT_PROFILE",
            .asset_type => "ASSET_TYPE",
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
