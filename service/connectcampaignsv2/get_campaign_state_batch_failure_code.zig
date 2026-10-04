const std = @import("std");

/// A predefined code indicating the error that caused the failure in getting
/// state of campaigns
pub const GetCampaignStateBatchFailureCode = enum {
    /// The specified resource was not found
    resource_not_found,
    /// Unexpected error during processing of request
    unknown_error,

    pub const json_field_names = .{
        .resource_not_found = "ResourceNotFound",
        .unknown_error = "UnknownError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_not_found => "ResourceNotFound",
            .unknown_error => "UnknownError",
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
