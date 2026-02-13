const PatchFilterKey = @import("patch_filter_key.zig").PatchFilterKey;

/// Defines which patches should be included in a patch baseline.
///
/// A patch filter consists of a key and a set of values. The filter key is a
/// patch property.
/// For example, the available filter keys for `WINDOWS` are `PATCH_SET`,
/// `PRODUCT`, `PRODUCT_FAMILY`, `CLASSIFICATION`, and
/// `MSRC_SEVERITY`.
///
/// The filter values define a matching criterion for the patch property
/// indicated by the key.
/// For example, if the filter key is `PRODUCT` and the filter values are
/// `["Office
/// 2013", "Office 2016"]`, then the filter accepts all patches where product
/// name is either
/// "Office 2013" or "Office 2016". The filter values can be exact values for
/// the patch property
/// given as a key, or a wildcard (*), which matches all values.
///
/// You can view lists of valid values for the patch properties by running the
/// `DescribePatchProperties` command. For information about which patch
/// properties can
/// be used with each major operating system, see DescribePatchProperties.
pub const PatchFilter = struct {
    /// The key for the filter.
    ///
    /// Run the DescribePatchProperties command to view lists of valid keys for
    /// each operating system type.
    key: PatchFilterKey,

    /// The value for the filter key.
    ///
    /// Run the DescribePatchProperties command to view lists of valid values for
    /// each key based on operating system type.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
