const ControlPlaneTagFilter = @import("control_plane_tag_filter.zig").ControlPlaneTagFilter;
const ControlPlaneUserAttributeFilter = @import("control_plane_user_attribute_filter.zig").ControlPlaneUserAttributeFilter;

/// Filters to be applied to search results.
pub const UserSearchFilter = struct {
    tag_filter: ?ControlPlaneTagFilter,

    /// An object that can be used to specify Tag conditions or Hierarchy Group
    /// conditions inside the
    /// SearchFilter.
    ///
    /// This accepts an `OR` of `AND` (List of List) input where:
    ///
    /// * The top level list specifies conditions that need to be applied with `OR`
    ///   operator.
    ///
    /// * The inner list specifies conditions that need to be applied with `AND`
    ///   operator.
    ///
    /// Only one field can be populated. This object can’t be used along with
    /// TagFilter. Request can either contain
    /// TagFilter or UserAttributeFilter if SearchFilter is specified, combination
    /// of both is not supported and such request
    /// will throw AccessDeniedException.
    user_attribute_filter: ?ControlPlaneUserAttributeFilter,

    pub const json_field_names = .{
        .tag_filter = "TagFilter",
        .user_attribute_filter = "UserAttributeFilter",
    };
};
