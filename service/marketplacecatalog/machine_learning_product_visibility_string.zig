/// The visibility status of a machine learning product. Valid values are:
///
/// * `Limited` - The product is available to a limited set of buyers.
///
/// * `Public` - The product is publicly available to all buyers.
///
/// * `Restricted` - The product has restricted availability.
///
/// * `Draft` - The product is in draft state and not yet available to buyers.
pub const MachineLearningProductVisibilityString = enum {
    limited,
    public,
    restricted,
    draft,

    pub const json_field_names = .{
        .limited = "Limited",
        .public = "Public",
        .restricted = "Restricted",
        .draft = "Draft",
    };
};
