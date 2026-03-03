const std = @import("std");

pub const DeviceFilterAttribute = enum {
    arn,
    platform,
    os_version,
    model,
    availability,
    form_factor,
    manufacturer,
    remote_access_enabled,
    remote_debug_enabled,
    instance_arn,
    instance_labels,
    fleet_type,

    pub const json_field_names = .{
        .arn = "ARN",
        .platform = "PLATFORM",
        .os_version = "OS_VERSION",
        .model = "MODEL",
        .availability = "AVAILABILITY",
        .form_factor = "FORM_FACTOR",
        .manufacturer = "MANUFACTURER",
        .remote_access_enabled = "REMOTE_ACCESS_ENABLED",
        .remote_debug_enabled = "REMOTE_DEBUG_ENABLED",
        .instance_arn = "INSTANCE_ARN",
        .instance_labels = "INSTANCE_LABELS",
        .fleet_type = "FLEET_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .arn => "ARN",
            .platform => "PLATFORM",
            .os_version => "OS_VERSION",
            .model => "MODEL",
            .availability => "AVAILABILITY",
            .form_factor => "FORM_FACTOR",
            .manufacturer => "MANUFACTURER",
            .remote_access_enabled => "REMOTE_ACCESS_ENABLED",
            .remote_debug_enabled => "REMOTE_DEBUG_ENABLED",
            .instance_arn => "INSTANCE_ARN",
            .instance_labels => "INSTANCE_LABELS",
            .fleet_type => "FLEET_TYPE",
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
