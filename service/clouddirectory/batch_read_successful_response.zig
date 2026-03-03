const BatchGetLinkAttributesResponse = @import("batch_get_link_attributes_response.zig").BatchGetLinkAttributesResponse;
const BatchGetObjectAttributesResponse = @import("batch_get_object_attributes_response.zig").BatchGetObjectAttributesResponse;
const BatchGetObjectInformationResponse = @import("batch_get_object_information_response.zig").BatchGetObjectInformationResponse;
const BatchListAttachedIndicesResponse = @import("batch_list_attached_indices_response.zig").BatchListAttachedIndicesResponse;
const BatchListIncomingTypedLinksResponse = @import("batch_list_incoming_typed_links_response.zig").BatchListIncomingTypedLinksResponse;
const BatchListIndexResponse = @import("batch_list_index_response.zig").BatchListIndexResponse;
const BatchListObjectAttributesResponse = @import("batch_list_object_attributes_response.zig").BatchListObjectAttributesResponse;
const BatchListObjectChildrenResponse = @import("batch_list_object_children_response.zig").BatchListObjectChildrenResponse;
const BatchListObjectParentPathsResponse = @import("batch_list_object_parent_paths_response.zig").BatchListObjectParentPathsResponse;
const BatchListObjectParentsResponse = @import("batch_list_object_parents_response.zig").BatchListObjectParentsResponse;
const BatchListObjectPoliciesResponse = @import("batch_list_object_policies_response.zig").BatchListObjectPoliciesResponse;
const BatchListOutgoingTypedLinksResponse = @import("batch_list_outgoing_typed_links_response.zig").BatchListOutgoingTypedLinksResponse;
const BatchListPolicyAttachmentsResponse = @import("batch_list_policy_attachments_response.zig").BatchListPolicyAttachmentsResponse;
const BatchLookupPolicyResponse = @import("batch_lookup_policy_response.zig").BatchLookupPolicyResponse;

/// Represents the output of a `BatchRead` success response operation.
pub const BatchReadSuccessfulResponse = struct {
    /// The list of attributes to retrieve from the typed link.
    get_link_attributes: ?BatchGetLinkAttributesResponse = null,

    /// Retrieves attributes within a facet that are associated with an object.
    get_object_attributes: ?BatchGetObjectAttributesResponse = null,

    /// Retrieves metadata about an object.
    get_object_information: ?BatchGetObjectInformationResponse = null,

    /// Lists indices attached to an object.
    list_attached_indices: ?BatchListAttachedIndicesResponse = null,

    /// Returns a paginated list of all the incoming TypedLinkSpecifier
    /// information for an object. It also supports filtering by typed link facet
    /// and identity
    /// attributes. For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    list_incoming_typed_links: ?BatchListIncomingTypedLinksResponse = null,

    /// Lists objects attached to the specified index.
    list_index: ?BatchListIndexResponse = null,

    /// Lists all attributes that are associated with an object.
    list_object_attributes: ?BatchListObjectAttributesResponse = null,

    /// Returns a paginated list of child objects that are associated with a given
    /// object.
    list_object_children: ?BatchListObjectChildrenResponse = null,

    /// Retrieves all available parent paths for any object type such as node, leaf
    /// node,
    /// policy node, and index node objects. For more information about objects, see
    /// [Directory
    /// Structure](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/key_concepts_directorystructure.html).
    list_object_parent_paths: ?BatchListObjectParentPathsResponse = null,

    /// The list of parent objects to retrieve.
    list_object_parents: ?BatchListObjectParentsResponse = null,

    /// Returns policies attached to an object in pagination fashion.
    list_object_policies: ?BatchListObjectPoliciesResponse = null,

    /// Returns a paginated list of all the outgoing TypedLinkSpecifier
    /// information for an object. It also supports filtering by typed link facet
    /// and identity
    /// attributes. For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    list_outgoing_typed_links: ?BatchListOutgoingTypedLinksResponse = null,

    /// Returns all of the `ObjectIdentifiers` to which a given policy is attached.
    list_policy_attachments: ?BatchListPolicyAttachmentsResponse = null,

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
    lookup_policy: ?BatchLookupPolicyResponse = null,

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
