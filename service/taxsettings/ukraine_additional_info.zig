const UkraineTrnType = @import("ukraine_trn_type.zig").UkraineTrnType;

/// Additional tax information associated with your TRN in Ukraine.
pub const UkraineAdditionalInfo = struct {
    /// The tax registration type.
    ukraine_trn_type: UkraineTrnType,

    pub const json_field_names = .{
        .ukraine_trn_type = "ukraineTrnType",
    };
};
