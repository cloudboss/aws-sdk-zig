const BatchAddFacetToObjectResponse = @import("batch_add_facet_to_object_response.zig").BatchAddFacetToObjectResponse;
const BatchAttachObjectResponse = @import("batch_attach_object_response.zig").BatchAttachObjectResponse;
const BatchAttachPolicyResponse = @import("batch_attach_policy_response.zig").BatchAttachPolicyResponse;
const BatchAttachToIndexResponse = @import("batch_attach_to_index_response.zig").BatchAttachToIndexResponse;
const BatchAttachTypedLinkResponse = @import("batch_attach_typed_link_response.zig").BatchAttachTypedLinkResponse;
const BatchCreateIndexResponse = @import("batch_create_index_response.zig").BatchCreateIndexResponse;
const BatchCreateObjectResponse = @import("batch_create_object_response.zig").BatchCreateObjectResponse;
const BatchDeleteObjectResponse = @import("batch_delete_object_response.zig").BatchDeleteObjectResponse;
const BatchDetachFromIndexResponse = @import("batch_detach_from_index_response.zig").BatchDetachFromIndexResponse;
const BatchDetachObjectResponse = @import("batch_detach_object_response.zig").BatchDetachObjectResponse;
const BatchDetachPolicyResponse = @import("batch_detach_policy_response.zig").BatchDetachPolicyResponse;
const BatchDetachTypedLinkResponse = @import("batch_detach_typed_link_response.zig").BatchDetachTypedLinkResponse;
const BatchRemoveFacetFromObjectResponse = @import("batch_remove_facet_from_object_response.zig").BatchRemoveFacetFromObjectResponse;
const BatchUpdateLinkAttributesResponse = @import("batch_update_link_attributes_response.zig").BatchUpdateLinkAttributesResponse;
const BatchUpdateObjectAttributesResponse = @import("batch_update_object_attributes_response.zig").BatchUpdateObjectAttributesResponse;

/// Represents the output of a `BatchWrite` response operation.
pub const BatchWriteOperationResponse = struct {
    /// The result of an add facet to object batch operation.
    add_facet_to_object: ?BatchAddFacetToObjectResponse = null,

    /// Attaches an object to a Directory.
    attach_object: ?BatchAttachObjectResponse = null,

    /// Attaches a policy object to a regular object. An object can have a limited
    /// number of attached
    /// policies.
    attach_policy: ?BatchAttachPolicyResponse = null,

    /// Attaches the specified object to the specified index.
    attach_to_index: ?BatchAttachToIndexResponse = null,

    /// Attaches a typed link to a specified source and target object. For more
    /// information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    attach_typed_link: ?BatchAttachTypedLinkResponse = null,

    /// Creates an index object. See [Indexing and
    /// search](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/indexing_search.htm) for more information.
    create_index: ?BatchCreateIndexResponse = null,

    /// Creates an object in a Directory.
    create_object: ?BatchCreateObjectResponse = null,

    /// Deletes an object in a Directory.
    delete_object: ?BatchDeleteObjectResponse = null,

    /// Detaches the specified object from the specified index.
    detach_from_index: ?BatchDetachFromIndexResponse = null,

    /// Detaches an object from a Directory.
    detach_object: ?BatchDetachObjectResponse = null,

    /// Detaches a policy from a Directory.
    detach_policy: ?BatchDetachPolicyResponse = null,

    /// Detaches a typed link from a specified source and target object. For more
    /// information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    detach_typed_link: ?BatchDetachTypedLinkResponse = null,

    /// The result of a batch remove facet from object operation.
    remove_facet_from_object: ?BatchRemoveFacetFromObjectResponse = null,

    /// Represents the output of a `BatchWrite` response operation.
    update_link_attributes: ?BatchUpdateLinkAttributesResponse = null,

    /// Updates a given object’s attributes.
    update_object_attributes: ?BatchUpdateObjectAttributesResponse = null,

    pub const json_field_names = .{
        .add_facet_to_object = "AddFacetToObject",
        .attach_object = "AttachObject",
        .attach_policy = "AttachPolicy",
        .attach_to_index = "AttachToIndex",
        .attach_typed_link = "AttachTypedLink",
        .create_index = "CreateIndex",
        .create_object = "CreateObject",
        .delete_object = "DeleteObject",
        .detach_from_index = "DetachFromIndex",
        .detach_object = "DetachObject",
        .detach_policy = "DetachPolicy",
        .detach_typed_link = "DetachTypedLink",
        .remove_facet_from_object = "RemoveFacetFromObject",
        .update_link_attributes = "UpdateLinkAttributes",
        .update_object_attributes = "UpdateObjectAttributes",
    };
};
