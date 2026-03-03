/// Object specifying the acceptable range of challenge versions.
pub const Versions = struct {
    /// The desired maximum version for the challenge.
    maximum: ?[]const u8 = null,

    /// The desired minimum version for the challenge.
    minimum: ?[]const u8 = null,

    pub const json_field_names = .{
        .maximum = "Maximum",
        .minimum = "Minimum",
    };
};
