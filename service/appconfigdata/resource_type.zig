const std = @import("std");

pub const ResourceType = enum {
    /// Resource type value for the Application resource.
    application,
    /// Resource type value for the ConfigurationProfile resource.
    configuration_profile,
    /// Resource type value for the Deployment resource.
    deployment,
    /// Resource type value for the Environment resource.
    environment,
    /// Resource type value for the Configuration resource.
    configuration,

    pub const json_field_names = .{
        .application = "Application",
        .configuration_profile = "ConfigurationProfile",
        .deployment = "Deployment",
        .environment = "Environment",
        .configuration = "Configuration",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .application => "Application",
            .configuration_profile => "ConfigurationProfile",
            .deployment => "Deployment",
            .environment => "Environment",
            .configuration => "Configuration",
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
