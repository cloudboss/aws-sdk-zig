const ResourceTypeForTagging = @import("resource_type_for_tagging.zig").ResourceTypeForTagging;
const Tag = @import("tag.zig").Tag;

pub const AddTagsToResourceRequest = struct {
    /// The resource ID you want to tag.
    ///
    /// Use the ID of the resource. Here are some examples:
    ///
    /// `MaintenanceWindow`: `mw-012345abcde`
    ///
    /// `PatchBaseline`: `pb-012345abcde`
    ///
    /// `Automation`: `example-c160-4567-8519-012345abcde`
    ///
    /// `OpsMetadata` object: `ResourceID` for tagging is created from the
    /// Amazon Resource Name (ARN) for the object. Specifically, `ResourceID` is
    /// created from
    /// the strings that come after the word `opsmetadata` in the ARN. For example,
    /// an
    /// OpsMetadata object with an ARN of
    /// `arn:aws:ssm:us-east-2:1234567890:opsmetadata/aws/ssm/MyGroup/appmanager`
    /// has a
    /// `ResourceID` of either `aws/ssm/MyGroup/appmanager` or
    /// `/aws/ssm/MyGroup/appmanager`.
    ///
    /// For the `Document` and `Parameter` values, use the name of the
    /// resource. If you're tagging a shared document, you must use the full ARN of
    /// the document.
    ///
    /// `ManagedInstance`: `mi-012345abcde`
    ///
    /// The `ManagedInstance` type for this API operation is only for on-premises
    /// managed nodes. You must specify the name of the managed node in the
    /// following format:
    /// `mi-*ID_number*
    /// `. For example,
    /// `mi-1a2b3c4d5e6f`.
    resource_id: []const u8,

    /// Specifies the type of resource you are tagging.
    ///
    /// The `ManagedInstance` type for this API operation is for on-premises managed
    /// nodes. You must specify the name of the managed node in the following
    /// format:
    /// `mi-*ID_number*
    /// `. For example,
    /// `mi-1a2b3c4d5e6f`.
    resource_type: ResourceTypeForTagging,

    /// One or more tags. The value parameter is required.
    ///
    /// Don't enter personally identifiable information in this field.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .tags = "Tags",
    };
};
