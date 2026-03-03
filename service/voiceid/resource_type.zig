const std = @import("std");

pub const ResourceType = enum {
    batch_job,
    compliance_consent,
    domain,
    fraudster,
    session,
    speaker,
    watchlist,

    pub const json_field_names = .{
        .batch_job = "BATCH_JOB",
        .compliance_consent = "COMPLIANCE_CONSENT",
        .domain = "DOMAIN",
        .fraudster = "FRAUDSTER",
        .session = "SESSION",
        .speaker = "SPEAKER",
        .watchlist = "WATCHLIST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .batch_job => "BATCH_JOB",
            .compliance_consent => "COMPLIANCE_CONSENT",
            .domain => "DOMAIN",
            .fraudster => "FRAUDSTER",
            .session => "SESSION",
            .speaker => "SPEAKER",
            .watchlist => "WATCHLIST",
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
