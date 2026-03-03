const BatchAddFacetToObject = @import("batch_add_facet_to_object.zig").BatchAddFacetToObject;
const BatchAttachObject = @import("batch_attach_object.zig").BatchAttachObject;
const BatchAttachPolicy = @import("batch_attach_policy.zig").BatchAttachPolicy;
const BatchAttachToIndex = @import("batch_attach_to_index.zig").BatchAttachToIndex;
const BatchAttachTypedLink = @import("batch_attach_typed_link.zig").BatchAttachTypedLink;
const BatchCreateIndex = @import("batch_create_index.zig").BatchCreateIndex;
const BatchCreateObject = @import("batch_create_object.zig").BatchCreateObject;
const BatchDeleteObject = @import("batch_delete_object.zig").BatchDeleteObject;
const BatchDetachFromIndex = @import("batch_detach_from_index.zig").BatchDetachFromIndex;
const BatchDetachObject = @import("batch_detach_object.zig").BatchDetachObject;
const BatchDetachPolicy = @import("batch_detach_policy.zig").BatchDetachPolicy;
const BatchDetachTypedLink = @import("batch_detach_typed_link.zig").BatchDetachTypedLink;
const BatchRemoveFacetFromObject = @import("batch_remove_facet_from_object.zig").BatchRemoveFacetFromObject;
const BatchUpdateLinkAttributes = @import("batch_update_link_attributes.zig").BatchUpdateLinkAttributes;
const BatchUpdateObjectAttributes = @import("batch_update_object_attributes.zig").BatchUpdateObjectAttributes;

/// Represents the output of a `BatchWrite` operation.
pub const BatchWriteOperation = struct {
    /// A batch operation that adds a facet to an object.
    add_facet_to_object: ?BatchAddFacetToObject = null,

    /// Attaches an object to a Directory.
    attach_object: ?BatchAttachObject = null,

    /// Attaches a policy object to a regular object. An object can have a limited
    /// number of attached
    /// policies.
    attach_policy: ?BatchAttachPolicy = null,

    /// Attaches the specified object to the specified index.
    attach_to_index: ?BatchAttachToIndex = null,

    /// Attaches a typed link to a specified source and target object. For more
    /// information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    attach_typed_link: ?BatchAttachTypedLink = null,

    /// Creates an index object. See [Indexing and
    /// search](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/indexing_search.htm) for more information.
    create_index: ?BatchCreateIndex = null,

    /// Creates an object.
    create_object: ?BatchCreateObject = null,

    /// Deletes an object in a Directory.
    delete_object: ?BatchDeleteObject = null,

    /// Detaches the specified object from the specified index.
    detach_from_index: ?BatchDetachFromIndex = null,

    /// Detaches an object from a Directory.
    detach_object: ?BatchDetachObject = null,

    /// Detaches a policy from a Directory.
    detach_policy: ?BatchDetachPolicy = null,

    /// Detaches a typed link from a specified source and target object. For more
    /// information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    detach_typed_link: ?BatchDetachTypedLink = null,

    /// A batch operation that removes a facet from an object.
    remove_facet_from_object: ?BatchRemoveFacetFromObject = null,

    /// Updates a given object's attributes.
    update_link_attributes: ?BatchUpdateLinkAttributes = null,

    /// Updates a given object's attributes.
    update_object_attributes: ?BatchUpdateObjectAttributes = null,

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
