const std = @import("std");

pub const RecommendationType = enum {
    dkim,
    dmarc,
    spf,
    bimi,
    complaint,
    bounce,
    feedback_3_p,
    ip_listing,

    pub const json_field_names = .{
        .dkim = "DKIM",
        .dmarc = "DMARC",
        .spf = "SPF",
        .bimi = "BIMI",
        .complaint = "COMPLAINT",
        .bounce = "BOUNCE",
        .feedback_3_p = "FEEDBACK_3P",
        .ip_listing = "IP_LISTING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dkim => "DKIM",
            .dmarc => "DMARC",
            .spf => "SPF",
            .bimi => "BIMI",
            .complaint => "COMPLAINT",
            .bounce => "BOUNCE",
            .feedback_3_p => "FEEDBACK_3P",
            .ip_listing => "IP_LISTING",
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
