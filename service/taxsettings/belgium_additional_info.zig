/// Additional tax information associated with your TRN in Belgium.
pub const BelgiumAdditionalInfo = struct {
    /// Indicates whether the Mercurius e-invoicing box is enabled for
    /// business-to-government (B2G) invoicing in Belgium.
    is_mercurius_box_enabled: ?bool = null,

    /// The Peppol ID for electronic invoicing in Belgium.
    peppol_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_mercurius_box_enabled = "isMercuriusBoxEnabled",
        .peppol_id = "peppolId",
    };
};
