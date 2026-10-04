const std = @import("std");

/// The billing domain for a billing view segment. The following values are
/// valid:
///
/// * `PRO_FORMA` - Data shaped by Billing Conductor that doesn't reflect the
///   final charges owed to Amazon Web Services.
/// * `BILLABLE` - Data that represents the final charges owed to Amazon Web
///   Services.
pub const BillingDomain = enum {
    billable,
    pro_forma,

    pub const json_field_names = .{
        .billable = "BILLABLE",
        .pro_forma = "PRO_FORMA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .billable => "BILLABLE",
            .pro_forma => "PRO_FORMA",
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
