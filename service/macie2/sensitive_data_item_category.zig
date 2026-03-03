const std = @import("std");

/// For a finding, the category of sensitive data that was detected and produced
/// the finding. For a managed data identifier, the category of sensitive data
/// that the managed data identifier detects. Possible values are:
pub const SensitiveDataItemCategory = enum {
    financial_information,
    personal_information,
    credentials,
    custom_identifier,

    pub const json_field_names = .{
        .financial_information = "FINANCIAL_INFORMATION",
        .personal_information = "PERSONAL_INFORMATION",
        .credentials = "CREDENTIALS",
        .custom_identifier = "CUSTOM_IDENTIFIER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .financial_information => "FINANCIAL_INFORMATION",
            .personal_information => "PERSONAL_INFORMATION",
            .credentials => "CREDENTIALS",
            .custom_identifier => "CUSTOM_IDENTIFIER",
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
