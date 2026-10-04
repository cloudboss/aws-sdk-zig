const std = @import("std");

pub const EventType = enum {
    thing,
    thing_group,
    thing_type,
    thing_group_membership,
    thing_group_hierarchy,
    thing_type_association,
    job,
    job_execution,
    policy,
    certificate,
    ca_certificate,

    pub const json_field_names = .{
        .thing = "THING",
        .thing_group = "THING_GROUP",
        .thing_type = "THING_TYPE",
        .thing_group_membership = "THING_GROUP_MEMBERSHIP",
        .thing_group_hierarchy = "THING_GROUP_HIERARCHY",
        .thing_type_association = "THING_TYPE_ASSOCIATION",
        .job = "JOB",
        .job_execution = "JOB_EXECUTION",
        .policy = "POLICY",
        .certificate = "CERTIFICATE",
        .ca_certificate = "CA_CERTIFICATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .thing => "THING",
            .thing_group => "THING_GROUP",
            .thing_type => "THING_TYPE",
            .thing_group_membership => "THING_GROUP_MEMBERSHIP",
            .thing_group_hierarchy => "THING_GROUP_HIERARCHY",
            .thing_type_association => "THING_TYPE_ASSOCIATION",
            .job => "JOB",
            .job_execution => "JOB_EXECUTION",
            .policy => "POLICY",
            .certificate => "CERTIFICATE",
            .ca_certificate => "CA_CERTIFICATE",
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
