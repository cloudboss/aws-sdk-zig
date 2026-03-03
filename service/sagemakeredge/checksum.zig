const ChecksumType = @import("checksum_type.zig").ChecksumType;

/// Information about the checksum of a model deployed on a device.
pub const Checksum = struct {
    /// The checksum of the model.
    sum: ?[]const u8 = null,

    /// The type of the checksum.
    @"type": ?ChecksumType = null,

    pub const json_field_names = .{
        .sum = "Sum",
        .@"type" = "Type",
    };
};
