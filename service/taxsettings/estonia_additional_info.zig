/// Additional tax information associated with your TRN in Estonia.
pub const EstoniaAdditionalInfo = struct {
    /// Registry commercial code (RCC) for your TRN in Estonia. This value is an
    /// eight-numeric
    /// string, such as `12345678`.
    registry_commercial_code: []const u8,

    pub const json_field_names = .{
        .registry_commercial_code = "registryCommercialCode",
    };
};
