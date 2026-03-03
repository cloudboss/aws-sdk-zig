const MonetaryValue = @import("monetary_value.zig").MonetaryValue;

/// Represents detailed information about a specific issuance of benefit value.
pub const IssuanceDetail = struct {
    /// The monetary amount or value that was issued in this specific issuance.
    issuance_amount: ?MonetaryValue = null,

    /// The unique identifier for this specific issuance.
    issuance_id: ?[]const u8 = null,

    /// The timestamp when this specific issuance was processed.
    issued_at: ?i64 = null,

    pub const json_field_names = .{
        .issuance_amount = "IssuanceAmount",
        .issuance_id = "IssuanceId",
        .issued_at = "IssuedAt",
    };
};
