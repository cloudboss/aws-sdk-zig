const std = @import("std");

/// This setting allows the delivery restriction flags on SCTE-35 segmentation
/// descriptors to
/// determine whether a message signals an ad. Choosing "NONE" means no SCTE-35
/// messages become
/// ads. Choosing "RESTRICTED" means SCTE-35 messages of the types specified in
/// AdTriggers that
/// contain delivery restrictions will be treated as ads. Choosing
/// "UNRESTRICTED" means SCTE-35
/// messages of the types specified in AdTriggers that do not contain delivery
/// restrictions will
/// be treated as ads. Choosing "BOTH" means all SCTE-35 messages of the types
/// specified in
/// AdTriggers will be treated as ads. Note that Splice Insert messages do not
/// have these flags
/// and are always treated as ads if specified in AdTriggers.
pub const AdsOnDeliveryRestrictions = enum {
    none,
    restricted,
    unrestricted,
    both,

    pub const json_field_names = .{
        .none = "NONE",
        .restricted = "RESTRICTED",
        .unrestricted = "UNRESTRICTED",
        .both = "BOTH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .restricted => "RESTRICTED",
            .unrestricted => "UNRESTRICTED",
            .both => "BOTH",
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
