/// Specifies the total weight for different axle group configurations. Used in
/// regions where regulations set different weight limits based on axle group
/// types.
///
/// **Unit**: `kilograms`
pub const WeightPerAxleGroup = struct {
    /// Total weight in kilograms for quad (four adjacent) axle configurations.
    ///
    /// **Unit**: `kilograms`
    quad: i64 = 0,

    /// Total weight in kilograms for quint (five adjacent) axle configurations.
    ///
    /// **Unit**: `kilograms`
    quint: i64 = 0,

    /// Total weight in kilograms for single axle configurations.
    ///
    /// **Unit**: `kilograms`
    single: i64 = 0,

    /// Total weight in kilograms for tandem (two adjacent) axle configurations.
    ///
    /// **Unit**: `kilograms`
    tandem: i64 = 0,

    /// Total weight in kilograms for triple (three adjacent) axle configurations.
    ///
    /// **Unit**: `kilograms`
    triple: i64 = 0,

    pub const json_field_names = .{
        .quad = "Quad",
        .quint = "Quint",
        .single = "Single",
        .tandem = "Tandem",
        .triple = "Triple",
    };
};
