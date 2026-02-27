const ValidityType = @import("validity_type.zig").ValidityType;

/// The validity period for a signing job.
pub const SignatureValidityPeriod = struct {
    /// The time unit for signature validity.
    type: ?ValidityType,

    /// The numerical value of the time unit for signature validity.
    value: i32 = 0,

    pub const json_field_names = .{
        .type = "type",
        .value = "value",
    };
};
