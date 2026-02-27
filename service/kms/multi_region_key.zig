/// Describes the primary or replica key in a multi-Region key.
pub const MultiRegionKey = struct {
    /// Displays the key ARN of a primary or replica key of a multi-Region key.
    arn: ?[]const u8,

    /// Displays the Amazon Web Services Region of a primary or replica key in a
    /// multi-Region key.
    region: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .region = "Region",
    };
};
