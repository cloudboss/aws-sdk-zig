const std = @import("std");

pub const EngagementInvitationPayloadType = enum {
    opportunity_invitation,
    lead_invitation,

    pub const json_field_names = .{
        .opportunity_invitation = "OpportunityInvitation",
        .lead_invitation = "LeadInvitation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .opportunity_invitation => "OpportunityInvitation",
            .lead_invitation => "LeadInvitation",
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
