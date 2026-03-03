const std = @import("std");

pub const MitigationActionType = enum {
    update_device_certificate,
    update_ca_certificate,
    add_things_to_thing_group,
    replace_default_policy_version,
    enable_iot_logging,
    publish_finding_to_sns,

    pub const json_field_names = .{
        .update_device_certificate = "UPDATE_DEVICE_CERTIFICATE",
        .update_ca_certificate = "UPDATE_CA_CERTIFICATE",
        .add_things_to_thing_group = "ADD_THINGS_TO_THING_GROUP",
        .replace_default_policy_version = "REPLACE_DEFAULT_POLICY_VERSION",
        .enable_iot_logging = "ENABLE_IOT_LOGGING",
        .publish_finding_to_sns = "PUBLISH_FINDING_TO_SNS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .update_device_certificate => "UPDATE_DEVICE_CERTIFICATE",
            .update_ca_certificate => "UPDATE_CA_CERTIFICATE",
            .add_things_to_thing_group => "ADD_THINGS_TO_THING_GROUP",
            .replace_default_policy_version => "REPLACE_DEFAULT_POLICY_VERSION",
            .enable_iot_logging => "ENABLE_IOT_LOGGING",
            .publish_finding_to_sns => "PUBLISH_FINDING_TO_SNS",
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
