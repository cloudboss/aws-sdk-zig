const Offering = @import("offering.zig").Offering;
const OfferingTransactionType = @import("offering_transaction_type.zig").OfferingTransactionType;

/// The status of the offering.
pub const OfferingStatus = struct {
    /// The date on which the offering is effective.
    effective_on: ?i64,

    /// Represents the metadata of an offering status.
    offering: ?Offering,

    /// The number of available devices in the offering.
    quantity: ?i32,

    /// The type specified for the offering status.
    type: ?OfferingTransactionType,

    pub const json_field_names = .{
        .effective_on = "effectiveOn",
        .offering = "offering",
        .quantity = "quantity",
        .type = "type",
    };
};
