const BatchGetLinkAttributes = @import("batch_get_link_attributes.zig").BatchGetLinkAttributes;
const BatchGetObjectAttributes = @import("batch_get_object_attributes.zig").BatchGetObjectAttributes;
const BatchGetObjectInformation = @import("batch_get_object_information.zig").BatchGetObjectInformation;
const BatchListAttachedIndices = @import("batch_list_attached_indices.zig").BatchListAttachedIndices;
const BatchListIncomingTypedLinks = @import("batch_list_incoming_typed_links.zig").BatchListIncomingTypedLinks;
const BatchListIndex = @import("batch_list_index.zig").BatchListIndex;
const BatchListObjectAttributes = @import("batch_list_object_attributes.zig").BatchListObjectAttributes;
const BatchListObjectChildren = @import("batch_list_object_children.zig").BatchListObjectChildren;
const BatchListObjectParentPaths = @import("batch_list_object_parent_paths.zig").BatchListObjectParentPaths;
const BatchListObjectParents = @import("batch_list_object_parents.zig").BatchListObjectParents;
const BatchListObjectPolicies = @import("batch_list_object_policies.zig").BatchListObjectPolicies;
const BatchListOutgoingTypedLinks = @import("batch_list_outgoing_typed_links.zig").BatchListOutgoingTypedLinks;
const BatchListPolicyAttachments = @import("batch_list_policy_attachments.zig").BatchListPolicyAttachments;
const BatchLookupPolicy = @import("batch_lookup_policy.zig").BatchLookupPolicy;

/// Represents the output of a `BatchRead` operation.
pub const BatchReadOperation = struct {
    /// Retrieves attributes that are associated with a typed link.
    get_link_attributes: ?BatchGetLinkAttributes,

    /// Retrieves attributes within a facet that are associated with an object.
    get_object_attributes: ?BatchGetObjectAttributes,

    /// Retrieves metadata about an object.
    get_object_information: ?BatchGetObjectInformation,

    /// Lists indices attached to an object.
    list_attached_indices: ?BatchListAttachedIndices,

    /// Returns a paginated list of all the incoming TypedLinkSpecifier
    /// information for an object. It also supports filtering by typed link facet
    /// and identity
    /// attributes. For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    list_incoming_typed_links: ?BatchListIncomingTypedLinks,

    /// Lists objects attached to the specified index.
    list_index: ?BatchListIndex,

    /// Lists all attributes that are associated with an object.
    list_object_attributes: ?BatchListObjectAttributes,

    /// Returns a paginated list of child objects that are associated with a given
    /// object.
    list_object_children: ?BatchListObjectChildren,

    /// Retrieves all available parent paths for any object type such as node, leaf
    /// node,
    /// policy node, and index node objects. For more information about objects, see
    /// [Directory
    /// Structure](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/key_concepts_directorystructure.html).
    list_object_parent_paths: ?BatchListObjectParentPaths,

    /// Lists parent objects that are associated with a given object in pagination
    /// fashion.
    list_object_parents: ?BatchListObjectParents,

    /// Returns policies attached to an object in pagination fashion.
    list_object_policies: ?BatchListObjectPolicies,

    /// Returns a paginated list of all the outgoing TypedLinkSpecifier
    /// information for an object. It also supports filtering by typed link facet
    /// and identity
    /// attributes. For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    list_outgoing_typed_links: ?BatchListOutgoingTypedLinks,

    /// Returns all of the `ObjectIdentifiers` to which a given policy is attached.
    list_policy_attachments: ?BatchListPolicyAttachments,

    /// Lists all policies from the root of the Directory to the object
    /// specified. If there are no policies present, an empty list is returned. If
    /// policies are
    /// present, and if some objects don't have the policies attached, it returns
    /// the `ObjectIdentifier`
    /// for such objects. If policies are present, it returns `ObjectIdentifier`,
    /// `policyId`, and
    /// `policyType`. Paths that don't lead to the root from the target object are
    /// ignored. For more
    /// information, see
    /// [Policies](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/key_concepts_directory.html#key_concepts_policies).
    lookup_policy: ?BatchLookupPolicy,

    pub const json_field_names = .{
        .get_link_attributes = "GetLinkAttributes",
        .get_object_attributes = "GetObjectAttributes",
        .get_object_information = "GetObjectInformation",
        .list_attached_indices = "ListAttachedIndices",
        .list_incoming_typed_links = "ListIncomingTypedLinks",
        .list_index = "ListIndex",
        .list_object_attributes = "ListObjectAttributes",
        .list_object_children = "ListObjectChildren",
        .list_object_parent_paths = "ListObjectParentPaths",
        .list_object_parents = "ListObjectParents",
        .list_object_policies = "ListObjectPolicies",
        .list_outgoing_typed_links = "ListOutgoingTypedLinks",
        .list_policy_attachments = "ListPolicyAttachments",
        .lookup_policy = "LookupPolicy",
    };
};
