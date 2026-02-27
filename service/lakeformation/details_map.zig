/// A structure containing the additional details to be returned in the
/// `AdditionalDetails` attribute of `PrincipalResourcePermissions`.
///
/// If a catalog resource is shared through Resource Access Manager (RAM), then
/// there will exist a corresponding RAM resource share ARN.
pub const DetailsMap = struct {
    /// A resource share ARN for a catalog resource shared through RAM.
    resource_share: ?[]const []const u8,

    pub const json_field_names = .{
        .resource_share = "ResourceShare",
    };
};
