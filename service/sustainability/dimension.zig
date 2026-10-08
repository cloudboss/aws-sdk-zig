const std = @import("std");

/// Specifies the dimensions available for grouping and filtering environmental
/// impact data.
pub const Dimension = enum {
    /// The account ID whose Amazon Web Services usage is associated with the
    /// estimated environmental impact data.
    usage_account_id,
    /// The geographical area containing data center clusters where Amazon Web
    /// Services services are hosted.
    region,
    /// The cloud computing product and solution offered by Amazon Web Services.
    service,

    pub const json_field_names = .{
        .usage_account_id = "USAGE_ACCOUNT_ID",
        .region = "REGION",
        .service = "SERVICE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .usage_account_id => "USAGE_ACCOUNT_ID",
            .region => "REGION",
            .service => "SERVICE",
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
