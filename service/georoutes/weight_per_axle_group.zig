/// Specifies the total weight for the specified axle group. Meant for usage in
/// countries that have different regulations based on the axle group type.
///
/// **Unit**: `Kilograms`
pub const WeightPerAxleGroup = struct {
    /// Weight for quad axle group.
    ///
    /// **Unit**: `Kilograms`
    quad: i64 = 0,

    /// Weight for quad quint group.
    ///
    /// **Unit**: `Kilograms`
    quint: i64 = 0,

    /// Weight for single axle group.
    ///
    /// **Unit**: `Kilograms`
    single: i64 = 0,

    /// Weight for tandem axle group.
    ///
    /// **Unit**: `Kilograms`
    tandem: i64 = 0,

    /// Weight for triple axle group.
    ///
    /// **Unit**: `Kilograms`
    triple: i64 = 0,

    pub const json_field_names = .{
        .quad = "Quad",
        .quint = "Quint",
        .single = "Single",
        .tandem = "Tandem",
        .triple = "Triple",
    };
};
