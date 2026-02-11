const WitnessStatus = @import("witness_status.zig").WitnessStatus;

/// Represents the properties of a witness Region in a MRSC global table.
pub const GlobalTableWitnessDescription = struct {
    /// The name of the Amazon Web Services Region that serves as a witness for the
    /// MRSC global
    /// table.
    region_name: ?[]const u8,

    /// The current status of the witness Region in the MRSC global table.
    witness_status: ?WitnessStatus,

    pub const json_field_names = .{
        .region_name = "RegionName",
        .witness_status = "WitnessStatus",
    };
};
