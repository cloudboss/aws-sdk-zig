const ResourceTypeForTagging = @import("resource_type_for_tagging.zig").ResourceTypeForTagging;

pub const RemoveTagsFromResourceRequest = struct {
    /// The ID of the resource from which you want to remove tags. For example:
    ///
    /// ManagedInstance: mi-012345abcde
    ///
    /// MaintenanceWindow: mw-012345abcde
    ///
    /// `Automation`: `example-c160-4567-8519-012345abcde`
    ///
    /// PatchBaseline: pb-012345abcde
    ///
    /// OpsMetadata object: `ResourceID` for tagging is created from the Amazon
    /// Resource
    /// Name (ARN) for the object. Specifically, `ResourceID` is created from the
    /// strings that
    /// come after the word `opsmetadata` in the ARN. For example, an OpsMetadata
    /// object with
    /// an ARN of
    /// `arn:aws:ssm:us-east-2:1234567890:opsmetadata/aws/ssm/MyGroup/appmanager`
    /// has a `ResourceID` of either `aws/ssm/MyGroup/appmanager` or
    /// `/aws/ssm/MyGroup/appmanager`.
    ///
    /// For the Document and Parameter values, use the name of the resource.
    ///
    /// The `ManagedInstance` type for this API operation is only for on-premises
    /// managed nodes. Specify the name of the managed node in the following format:
    /// mi-ID_number. For
    /// example, mi-1a2b3c4d5e6f.
    resource_id: []const u8,

    /// The type of resource from which you want to remove a tag.
    ///
    /// The `ManagedInstance` type for this API operation is only for on-premises
    /// managed nodes. Specify the name of the managed node in the following format:
    /// `mi-*ID_number*
    /// `. For example,
    /// `mi-1a2b3c4d5e6f`.
    resource_type: ResourceTypeForTagging,

    /// Tag keys that you want to remove from the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .tag_keys = "TagKeys",
    };
};
