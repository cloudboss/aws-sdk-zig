/// SearchNearby structure which contains a set of inclusion/exclusion
/// properties that results must possess in order to be returned as a result.
pub const SearchNearbyFilter = struct {
    /// The bounding box enclosing the geometric shape (area or line) that an
    /// individual result covers.
    ///
    /// The bounding box formed is defined as a set 4 coordinates: `[{westward lng},
    /// {southern lat}, {eastward lng}, {northern lat}]`
    bounding_box: ?[]const f64 = null,

    /// The Business Chains associated with the place.
    exclude_business_chains: ?[]const []const u8 = null,

    /// Categories of results that results are excluded from.
    exclude_categories: ?[]const []const u8 = null,

    /// Food types that results are excluded from.
    exclude_food_types: ?[]const []const u8 = null,

    /// The Business Chains associated with the place.
    include_business_chains: ?[]const []const u8 = null,

    /// Categories of results that results must belong too.
    include_categories: ?[]const []const u8 = null,

    /// A list of countries that all results must be in. Countries are represented
    /// by either their alpha-2 or alpha-3 character codes.
    include_countries: ?[]const []const u8 = null,

    /// Food types that results are included from.
    include_food_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .exclude_business_chains = "ExcludeBusinessChains",
        .exclude_categories = "ExcludeCategories",
        .exclude_food_types = "ExcludeFoodTypes",
        .include_business_chains = "IncludeBusinessChains",
        .include_categories = "IncludeCategories",
        .include_countries = "IncludeCountries",
        .include_food_types = "IncludeFoodTypes",
    };
};
