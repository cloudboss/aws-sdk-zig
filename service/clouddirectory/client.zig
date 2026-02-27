const aws = @import("aws");
const std = @import("std");

const add_facet_to_object = @import("add_facet_to_object.zig");
const apply_schema = @import("apply_schema.zig");
const attach_object = @import("attach_object.zig");
const attach_policy = @import("attach_policy.zig");
const attach_to_index = @import("attach_to_index.zig");
const attach_typed_link = @import("attach_typed_link.zig");
const batch_read = @import("batch_read.zig");
const batch_write = @import("batch_write.zig");
const create_directory = @import("create_directory.zig");
const create_facet = @import("create_facet.zig");
const create_index = @import("create_index.zig");
const create_object = @import("create_object.zig");
const create_schema = @import("create_schema.zig");
const create_typed_link_facet = @import("create_typed_link_facet.zig");
const delete_directory = @import("delete_directory.zig");
const delete_facet = @import("delete_facet.zig");
const delete_object = @import("delete_object.zig");
const delete_schema = @import("delete_schema.zig");
const delete_typed_link_facet = @import("delete_typed_link_facet.zig");
const detach_from_index = @import("detach_from_index.zig");
const detach_object = @import("detach_object.zig");
const detach_policy = @import("detach_policy.zig");
const detach_typed_link = @import("detach_typed_link.zig");
const disable_directory = @import("disable_directory.zig");
const enable_directory = @import("enable_directory.zig");
const get_applied_schema_version = @import("get_applied_schema_version.zig");
const get_directory = @import("get_directory.zig");
const get_facet = @import("get_facet.zig");
const get_link_attributes = @import("get_link_attributes.zig");
const get_object_attributes = @import("get_object_attributes.zig");
const get_object_information = @import("get_object_information.zig");
const get_schema_as_json = @import("get_schema_as_json.zig");
const get_typed_link_facet_information = @import("get_typed_link_facet_information.zig");
const list_applied_schema_arns = @import("list_applied_schema_arns.zig");
const list_attached_indices = @import("list_attached_indices.zig");
const list_development_schema_arns = @import("list_development_schema_arns.zig");
const list_directories = @import("list_directories.zig");
const list_facet_attributes = @import("list_facet_attributes.zig");
const list_facet_names = @import("list_facet_names.zig");
const list_incoming_typed_links = @import("list_incoming_typed_links.zig");
const list_index = @import("list_index.zig");
const list_managed_schema_arns = @import("list_managed_schema_arns.zig");
const list_object_attributes = @import("list_object_attributes.zig");
const list_object_children = @import("list_object_children.zig");
const list_object_parent_paths = @import("list_object_parent_paths.zig");
const list_object_parents = @import("list_object_parents.zig");
const list_object_policies = @import("list_object_policies.zig");
const list_outgoing_typed_links = @import("list_outgoing_typed_links.zig");
const list_policy_attachments = @import("list_policy_attachments.zig");
const list_published_schema_arns = @import("list_published_schema_arns.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_typed_link_facet_attributes = @import("list_typed_link_facet_attributes.zig");
const list_typed_link_facet_names = @import("list_typed_link_facet_names.zig");
const lookup_policy = @import("lookup_policy.zig");
const publish_schema = @import("publish_schema.zig");
const put_schema_from_json = @import("put_schema_from_json.zig");
const remove_facet_from_object = @import("remove_facet_from_object.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_facet = @import("update_facet.zig");
const update_link_attributes = @import("update_link_attributes.zig");
const update_object_attributes = @import("update_object_attributes.zig");
const update_schema = @import("update_schema.zig");
const update_typed_link_facet = @import("update_typed_link_facet.zig");
const upgrade_applied_schema = @import("upgrade_applied_schema.zig");
const upgrade_published_schema = @import("upgrade_published_schema.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudDirectory";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Adds a new Facet to an object. An object can have more than one facet
    /// applied on it.
    pub fn addFacetToObject(self: *Self, allocator: std.mem.Allocator, input: add_facet_to_object.AddFacetToObjectInput, options: add_facet_to_object.Options) !add_facet_to_object.AddFacetToObjectOutput {
        return add_facet_to_object.execute(self, allocator, input, options);
    }

    /// Copies the input published schema, at the specified version, into the
    /// Directory with the same
    /// name and version as that of the published schema.
    pub fn applySchema(self: *Self, allocator: std.mem.Allocator, input: apply_schema.ApplySchemaInput, options: apply_schema.Options) !apply_schema.ApplySchemaOutput {
        return apply_schema.execute(self, allocator, input, options);
    }

    /// Attaches an existing object to another object. An object can be accessed in
    /// two
    /// ways:
    ///
    /// * Using the path
    ///
    /// * Using `ObjectIdentifier`
    pub fn attachObject(self: *Self, allocator: std.mem.Allocator, input: attach_object.AttachObjectInput, options: attach_object.Options) !attach_object.AttachObjectOutput {
        return attach_object.execute(self, allocator, input, options);
    }

    /// Attaches a policy object to a regular object. An object can have a limited
    /// number of attached
    /// policies.
    pub fn attachPolicy(self: *Self, allocator: std.mem.Allocator, input: attach_policy.AttachPolicyInput, options: attach_policy.Options) !attach_policy.AttachPolicyOutput {
        return attach_policy.execute(self, allocator, input, options);
    }

    /// Attaches the specified object to the specified index.
    pub fn attachToIndex(self: *Self, allocator: std.mem.Allocator, input: attach_to_index.AttachToIndexInput, options: attach_to_index.Options) !attach_to_index.AttachToIndexOutput {
        return attach_to_index.execute(self, allocator, input, options);
    }

    /// Attaches a typed link to a specified source and target object. For more
    /// information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    pub fn attachTypedLink(self: *Self, allocator: std.mem.Allocator, input: attach_typed_link.AttachTypedLinkInput, options: attach_typed_link.Options) !attach_typed_link.AttachTypedLinkOutput {
        return attach_typed_link.execute(self, allocator, input, options);
    }

    /// Performs all the read operations in a batch.
    pub fn batchRead(self: *Self, allocator: std.mem.Allocator, input: batch_read.BatchReadInput, options: batch_read.Options) !batch_read.BatchReadOutput {
        return batch_read.execute(self, allocator, input, options);
    }

    /// Performs all the write operations in a batch. Either all the operations
    /// succeed or
    /// none.
    pub fn batchWrite(self: *Self, allocator: std.mem.Allocator, input: batch_write.BatchWriteInput, options: batch_write.Options) !batch_write.BatchWriteOutput {
        return batch_write.execute(self, allocator, input, options);
    }

    /// Creates a Directory by copying the published schema into the
    /// directory. A directory cannot be created without a schema.
    ///
    /// You can also quickly create a directory using a managed schema, called the
    /// `QuickStartSchema`. For more information, see [Managed
    /// Schema](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/schemas_managed.html) in the *Amazon Cloud Directory Developer Guide*.
    pub fn createDirectory(self: *Self, allocator: std.mem.Allocator, input: create_directory.CreateDirectoryInput, options: create_directory.Options) !create_directory.CreateDirectoryOutput {
        return create_directory.execute(self, allocator, input, options);
    }

    /// Creates a new Facet in a schema. Facet creation is allowed only
    /// in development or applied schemas.
    pub fn createFacet(self: *Self, allocator: std.mem.Allocator, input: create_facet.CreateFacetInput, options: create_facet.Options) !create_facet.CreateFacetOutput {
        return create_facet.execute(self, allocator, input, options);
    }

    /// Creates an index object. See [Indexing and
    /// search](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/indexing_search.html) for more information.
    pub fn createIndex(self: *Self, allocator: std.mem.Allocator, input: create_index.CreateIndexInput, options: create_index.Options) !create_index.CreateIndexOutput {
        return create_index.execute(self, allocator, input, options);
    }

    /// Creates an object in a Directory. Additionally attaches the object to
    /// a parent, if a parent reference and `LinkName` is specified. An object is
    /// simply a
    /// collection of Facet attributes. You can also use this API call to create a
    /// policy object, if the facet from which you create the object is a policy
    /// facet.
    pub fn createObject(self: *Self, allocator: std.mem.Allocator, input: create_object.CreateObjectInput, options: create_object.Options) !create_object.CreateObjectOutput {
        return create_object.execute(self, allocator, input, options);
    }

    /// Creates a new schema in a development state. A schema can exist in three
    /// phases:
    ///
    /// * *Development:* This is a mutable phase of the schema. All new
    /// schemas are in the development phase. Once the schema is finalized, it can
    /// be
    /// published.
    ///
    /// * *Published:* Published schemas are immutable and have a version
    /// associated with them.
    ///
    /// * *Applied:* Applied schemas are mutable in a way that allows you
    /// to add new schema facets. You can also add new, nonrequired attributes to
    /// existing schema
    /// facets. You can apply only published schemas to directories.
    pub fn createSchema(self: *Self, allocator: std.mem.Allocator, input: create_schema.CreateSchemaInput, options: create_schema.Options) !create_schema.CreateSchemaOutput {
        return create_schema.execute(self, allocator, input, options);
    }

    /// Creates a TypedLinkFacet. For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    pub fn createTypedLinkFacet(self: *Self, allocator: std.mem.Allocator, input: create_typed_link_facet.CreateTypedLinkFacetInput, options: create_typed_link_facet.Options) !create_typed_link_facet.CreateTypedLinkFacetOutput {
        return create_typed_link_facet.execute(self, allocator, input, options);
    }

    /// Deletes a directory. Only disabled directories can be deleted. A deleted
    /// directory cannot be undone. Exercise extreme
    /// caution
    /// when deleting directories.
    pub fn deleteDirectory(self: *Self, allocator: std.mem.Allocator, input: delete_directory.DeleteDirectoryInput, options: delete_directory.Options) !delete_directory.DeleteDirectoryOutput {
        return delete_directory.execute(self, allocator, input, options);
    }

    /// Deletes a given Facet. All attributes and Rules
    /// that are associated with the facet will be deleted. Only development schema
    /// facets are allowed
    /// deletion.
    pub fn deleteFacet(self: *Self, allocator: std.mem.Allocator, input: delete_facet.DeleteFacetInput, options: delete_facet.Options) !delete_facet.DeleteFacetOutput {
        return delete_facet.execute(self, allocator, input, options);
    }

    /// Deletes an object and its associated attributes. Only objects with no
    /// children and no
    /// parents can be deleted. The maximum number of attributes that can be deleted
    /// during an object deletion is 30. For more information, see [Amazon Cloud
    /// Directory
    /// Limits](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/limits.html).
    pub fn deleteObject(self: *Self, allocator: std.mem.Allocator, input: delete_object.DeleteObjectInput, options: delete_object.Options) !delete_object.DeleteObjectOutput {
        return delete_object.execute(self, allocator, input, options);
    }

    /// Deletes a given schema. Schemas in a development and published state can
    /// only be deleted.
    pub fn deleteSchema(self: *Self, allocator: std.mem.Allocator, input: delete_schema.DeleteSchemaInput, options: delete_schema.Options) !delete_schema.DeleteSchemaOutput {
        return delete_schema.execute(self, allocator, input, options);
    }

    /// Deletes a TypedLinkFacet. For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    pub fn deleteTypedLinkFacet(self: *Self, allocator: std.mem.Allocator, input: delete_typed_link_facet.DeleteTypedLinkFacetInput, options: delete_typed_link_facet.Options) !delete_typed_link_facet.DeleteTypedLinkFacetOutput {
        return delete_typed_link_facet.execute(self, allocator, input, options);
    }

    /// Detaches the specified object from the specified index.
    pub fn detachFromIndex(self: *Self, allocator: std.mem.Allocator, input: detach_from_index.DetachFromIndexInput, options: detach_from_index.Options) !detach_from_index.DetachFromIndexOutput {
        return detach_from_index.execute(self, allocator, input, options);
    }

    /// Detaches a given object from the parent object. The object that is to be
    /// detached from the
    /// parent is specified by the link name.
    pub fn detachObject(self: *Self, allocator: std.mem.Allocator, input: detach_object.DetachObjectInput, options: detach_object.Options) !detach_object.DetachObjectOutput {
        return detach_object.execute(self, allocator, input, options);
    }

    /// Detaches a policy from an object.
    pub fn detachPolicy(self: *Self, allocator: std.mem.Allocator, input: detach_policy.DetachPolicyInput, options: detach_policy.Options) !detach_policy.DetachPolicyOutput {
        return detach_policy.execute(self, allocator, input, options);
    }

    /// Detaches a typed link from a specified source and target object. For more
    /// information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    pub fn detachTypedLink(self: *Self, allocator: std.mem.Allocator, input: detach_typed_link.DetachTypedLinkInput, options: detach_typed_link.Options) !detach_typed_link.DetachTypedLinkOutput {
        return detach_typed_link.execute(self, allocator, input, options);
    }

    /// Disables the specified directory. Disabled directories cannot be read or
    /// written to.
    /// Only enabled directories can be disabled. Disabled directories may be
    /// reenabled.
    pub fn disableDirectory(self: *Self, allocator: std.mem.Allocator, input: disable_directory.DisableDirectoryInput, options: disable_directory.Options) !disable_directory.DisableDirectoryOutput {
        return disable_directory.execute(self, allocator, input, options);
    }

    /// Enables the specified directory. Only disabled directories can be enabled.
    /// Once
    /// enabled, the directory can then be read and written to.
    pub fn enableDirectory(self: *Self, allocator: std.mem.Allocator, input: enable_directory.EnableDirectoryInput, options: enable_directory.Options) !enable_directory.EnableDirectoryOutput {
        return enable_directory.execute(self, allocator, input, options);
    }

    /// Returns current applied schema version ARN, including the minor version in
    /// use.
    pub fn getAppliedSchemaVersion(self: *Self, allocator: std.mem.Allocator, input: get_applied_schema_version.GetAppliedSchemaVersionInput, options: get_applied_schema_version.Options) !get_applied_schema_version.GetAppliedSchemaVersionOutput {
        return get_applied_schema_version.execute(self, allocator, input, options);
    }

    /// Retrieves metadata about a directory.
    pub fn getDirectory(self: *Self, allocator: std.mem.Allocator, input: get_directory.GetDirectoryInput, options: get_directory.Options) !get_directory.GetDirectoryOutput {
        return get_directory.execute(self, allocator, input, options);
    }

    /// Gets details of the Facet, such as facet name, attributes, Rules, or
    /// `ObjectType`. You can call this on all kinds of schema
    /// facets -- published, development, or applied.
    pub fn getFacet(self: *Self, allocator: std.mem.Allocator, input: get_facet.GetFacetInput, options: get_facet.Options) !get_facet.GetFacetOutput {
        return get_facet.execute(self, allocator, input, options);
    }

    /// Retrieves attributes that are associated with a typed link.
    pub fn getLinkAttributes(self: *Self, allocator: std.mem.Allocator, input: get_link_attributes.GetLinkAttributesInput, options: get_link_attributes.Options) !get_link_attributes.GetLinkAttributesOutput {
        return get_link_attributes.execute(self, allocator, input, options);
    }

    /// Retrieves attributes within a facet that are associated with an object.
    pub fn getObjectAttributes(self: *Self, allocator: std.mem.Allocator, input: get_object_attributes.GetObjectAttributesInput, options: get_object_attributes.Options) !get_object_attributes.GetObjectAttributesOutput {
        return get_object_attributes.execute(self, allocator, input, options);
    }

    /// Retrieves metadata about an object.
    pub fn getObjectInformation(self: *Self, allocator: std.mem.Allocator, input: get_object_information.GetObjectInformationInput, options: get_object_information.Options) !get_object_information.GetObjectInformationOutput {
        return get_object_information.execute(self, allocator, input, options);
    }

    /// Retrieves a JSON representation of the schema. See [JSON Schema
    /// Format](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/schemas_jsonformat.html#schemas_json) for more information.
    pub fn getSchemaAsJson(self: *Self, allocator: std.mem.Allocator, input: get_schema_as_json.GetSchemaAsJsonInput, options: get_schema_as_json.Options) !get_schema_as_json.GetSchemaAsJsonOutput {
        return get_schema_as_json.execute(self, allocator, input, options);
    }

    /// Returns the identity attribute order for a specific TypedLinkFacet. For more
    /// information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    pub fn getTypedLinkFacetInformation(self: *Self, allocator: std.mem.Allocator, input: get_typed_link_facet_information.GetTypedLinkFacetInformationInput, options: get_typed_link_facet_information.Options) !get_typed_link_facet_information.GetTypedLinkFacetInformationOutput {
        return get_typed_link_facet_information.execute(self, allocator, input, options);
    }

    /// Lists schema major versions applied to a directory. If `SchemaArn` is
    /// provided, lists the minor version.
    pub fn listAppliedSchemaArns(self: *Self, allocator: std.mem.Allocator, input: list_applied_schema_arns.ListAppliedSchemaArnsInput, options: list_applied_schema_arns.Options) !list_applied_schema_arns.ListAppliedSchemaArnsOutput {
        return list_applied_schema_arns.execute(self, allocator, input, options);
    }

    /// Lists indices attached to the specified object.
    pub fn listAttachedIndices(self: *Self, allocator: std.mem.Allocator, input: list_attached_indices.ListAttachedIndicesInput, options: list_attached_indices.Options) !list_attached_indices.ListAttachedIndicesOutput {
        return list_attached_indices.execute(self, allocator, input, options);
    }

    /// Retrieves each Amazon Resource Name (ARN) of schemas in the development
    /// state.
    pub fn listDevelopmentSchemaArns(self: *Self, allocator: std.mem.Allocator, input: list_development_schema_arns.ListDevelopmentSchemaArnsInput, options: list_development_schema_arns.Options) !list_development_schema_arns.ListDevelopmentSchemaArnsOutput {
        return list_development_schema_arns.execute(self, allocator, input, options);
    }

    /// Lists directories created within an account.
    pub fn listDirectories(self: *Self, allocator: std.mem.Allocator, input: list_directories.ListDirectoriesInput, options: list_directories.Options) !list_directories.ListDirectoriesOutput {
        return list_directories.execute(self, allocator, input, options);
    }

    /// Retrieves attributes attached to the facet.
    pub fn listFacetAttributes(self: *Self, allocator: std.mem.Allocator, input: list_facet_attributes.ListFacetAttributesInput, options: list_facet_attributes.Options) !list_facet_attributes.ListFacetAttributesOutput {
        return list_facet_attributes.execute(self, allocator, input, options);
    }

    /// Retrieves the names of facets that exist in a schema.
    pub fn listFacetNames(self: *Self, allocator: std.mem.Allocator, input: list_facet_names.ListFacetNamesInput, options: list_facet_names.Options) !list_facet_names.ListFacetNamesOutput {
        return list_facet_names.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of all the incoming TypedLinkSpecifier
    /// information for an object. It also supports filtering by typed link facet
    /// and identity
    /// attributes. For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    pub fn listIncomingTypedLinks(self: *Self, allocator: std.mem.Allocator, input: list_incoming_typed_links.ListIncomingTypedLinksInput, options: list_incoming_typed_links.Options) !list_incoming_typed_links.ListIncomingTypedLinksOutput {
        return list_incoming_typed_links.execute(self, allocator, input, options);
    }

    /// Lists objects attached to the specified index.
    pub fn listIndex(self: *Self, allocator: std.mem.Allocator, input: list_index.ListIndexInput, options: list_index.Options) !list_index.ListIndexOutput {
        return list_index.execute(self, allocator, input, options);
    }

    /// Lists the major version families of each managed schema. If a major version
    /// ARN is provided as SchemaArn, the minor version revisions in that family are
    /// listed instead.
    pub fn listManagedSchemaArns(self: *Self, allocator: std.mem.Allocator, input: list_managed_schema_arns.ListManagedSchemaArnsInput, options: list_managed_schema_arns.Options) !list_managed_schema_arns.ListManagedSchemaArnsOutput {
        return list_managed_schema_arns.execute(self, allocator, input, options);
    }

    /// Lists all attributes that are associated with an object.
    pub fn listObjectAttributes(self: *Self, allocator: std.mem.Allocator, input: list_object_attributes.ListObjectAttributesInput, options: list_object_attributes.Options) !list_object_attributes.ListObjectAttributesOutput {
        return list_object_attributes.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of child objects that are associated with a given
    /// object.
    pub fn listObjectChildren(self: *Self, allocator: std.mem.Allocator, input: list_object_children.ListObjectChildrenInput, options: list_object_children.Options) !list_object_children.ListObjectChildrenOutput {
        return list_object_children.execute(self, allocator, input, options);
    }

    /// Retrieves all available parent paths for any object type such as node, leaf
    /// node,
    /// policy node, and index node objects. For more information about objects, see
    /// [Directory
    /// Structure](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/key_concepts_directorystructure.html).
    ///
    /// Use this API to evaluate all parents for an object. The call returns all
    /// objects from
    /// the root of the directory up to the requested object. The API returns the
    /// number of paths
    /// based on user-defined `MaxResults`, in case there are multiple paths to the
    /// parent.
    /// The order of the paths and nodes returned is consistent among multiple API
    /// calls unless the
    /// objects are deleted or moved. Paths not leading to the directory root are
    /// ignored from the
    /// target object.
    pub fn listObjectParentPaths(self: *Self, allocator: std.mem.Allocator, input: list_object_parent_paths.ListObjectParentPathsInput, options: list_object_parent_paths.Options) !list_object_parent_paths.ListObjectParentPathsOutput {
        return list_object_parent_paths.execute(self, allocator, input, options);
    }

    /// Lists parent objects that are associated with a given object in pagination
    /// fashion.
    pub fn listObjectParents(self: *Self, allocator: std.mem.Allocator, input: list_object_parents.ListObjectParentsInput, options: list_object_parents.Options) !list_object_parents.ListObjectParentsOutput {
        return list_object_parents.execute(self, allocator, input, options);
    }

    /// Returns policies attached to an object in pagination fashion.
    pub fn listObjectPolicies(self: *Self, allocator: std.mem.Allocator, input: list_object_policies.ListObjectPoliciesInput, options: list_object_policies.Options) !list_object_policies.ListObjectPoliciesOutput {
        return list_object_policies.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of all the outgoing TypedLinkSpecifier
    /// information for an object. It also supports filtering by typed link facet
    /// and identity
    /// attributes. For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    pub fn listOutgoingTypedLinks(self: *Self, allocator: std.mem.Allocator, input: list_outgoing_typed_links.ListOutgoingTypedLinksInput, options: list_outgoing_typed_links.Options) !list_outgoing_typed_links.ListOutgoingTypedLinksOutput {
        return list_outgoing_typed_links.execute(self, allocator, input, options);
    }

    /// Returns all of the `ObjectIdentifiers` to which a given policy is attached.
    pub fn listPolicyAttachments(self: *Self, allocator: std.mem.Allocator, input: list_policy_attachments.ListPolicyAttachmentsInput, options: list_policy_attachments.Options) !list_policy_attachments.ListPolicyAttachmentsOutput {
        return list_policy_attachments.execute(self, allocator, input, options);
    }

    /// Lists the major version families of each published schema. If a major
    /// version ARN is provided as `SchemaArn`, the minor version revisions in that
    /// family are listed instead.
    pub fn listPublishedSchemaArns(self: *Self, allocator: std.mem.Allocator, input: list_published_schema_arns.ListPublishedSchemaArnsInput, options: list_published_schema_arns.Options) !list_published_schema_arns.ListPublishedSchemaArnsOutput {
        return list_published_schema_arns.execute(self, allocator, input, options);
    }

    /// Returns tags for a resource. Tagging is currently supported only for
    /// directories with a
    /// limit of 50 tags per directory. All 50 tags are returned for a given
    /// directory with this API
    /// call.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of all attribute definitions for a particular
    /// TypedLinkFacet. For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    pub fn listTypedLinkFacetAttributes(self: *Self, allocator: std.mem.Allocator, input: list_typed_link_facet_attributes.ListTypedLinkFacetAttributesInput, options: list_typed_link_facet_attributes.Options) !list_typed_link_facet_attributes.ListTypedLinkFacetAttributesOutput {
        return list_typed_link_facet_attributes.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of `TypedLink` facet names for a particular schema.
    /// For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    pub fn listTypedLinkFacetNames(self: *Self, allocator: std.mem.Allocator, input: list_typed_link_facet_names.ListTypedLinkFacetNamesInput, options: list_typed_link_facet_names.Options) !list_typed_link_facet_names.ListTypedLinkFacetNamesOutput {
        return list_typed_link_facet_names.execute(self, allocator, input, options);
    }

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
    pub fn lookupPolicy(self: *Self, allocator: std.mem.Allocator, input: lookup_policy.LookupPolicyInput, options: lookup_policy.Options) !lookup_policy.LookupPolicyOutput {
        return lookup_policy.execute(self, allocator, input, options);
    }

    /// Publishes a development schema with a major version and a recommended minor
    /// version.
    pub fn publishSchema(self: *Self, allocator: std.mem.Allocator, input: publish_schema.PublishSchemaInput, options: publish_schema.Options) !publish_schema.PublishSchemaOutput {
        return publish_schema.execute(self, allocator, input, options);
    }

    /// Allows a schema to be updated using JSON upload. Only available for
    /// development schemas. See [JSON Schema
    /// Format](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/schemas_jsonformat.html#schemas_json) for more information.
    pub fn putSchemaFromJson(self: *Self, allocator: std.mem.Allocator, input: put_schema_from_json.PutSchemaFromJsonInput, options: put_schema_from_json.Options) !put_schema_from_json.PutSchemaFromJsonOutput {
        return put_schema_from_json.execute(self, allocator, input, options);
    }

    /// Removes the specified facet from the specified object.
    pub fn removeFacetFromObject(self: *Self, allocator: std.mem.Allocator, input: remove_facet_from_object.RemoveFacetFromObjectInput, options: remove_facet_from_object.Options) !remove_facet_from_object.RemoveFacetFromObjectOutput {
        return remove_facet_from_object.execute(self, allocator, input, options);
    }

    /// An API operation for adding tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// An API operation for removing tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Does the following:
    ///
    /// * Adds new `Attributes`, `Rules`, or `ObjectTypes`.
    ///
    /// * Updates existing `Attributes`, `Rules`, or `ObjectTypes`.
    ///
    /// * Deletes existing `Attributes`, `Rules`, or `ObjectTypes`.
    pub fn updateFacet(self: *Self, allocator: std.mem.Allocator, input: update_facet.UpdateFacetInput, options: update_facet.Options) !update_facet.UpdateFacetOutput {
        return update_facet.execute(self, allocator, input, options);
    }

    /// Updates a given typed link’s attributes. Attributes to be updated must not
    /// contribute to the typed link’s identity, as defined by its
    /// `IdentityAttributeOrder`.
    pub fn updateLinkAttributes(self: *Self, allocator: std.mem.Allocator, input: update_link_attributes.UpdateLinkAttributesInput, options: update_link_attributes.Options) !update_link_attributes.UpdateLinkAttributesOutput {
        return update_link_attributes.execute(self, allocator, input, options);
    }

    /// Updates a given object's attributes.
    pub fn updateObjectAttributes(self: *Self, allocator: std.mem.Allocator, input: update_object_attributes.UpdateObjectAttributesInput, options: update_object_attributes.Options) !update_object_attributes.UpdateObjectAttributesOutput {
        return update_object_attributes.execute(self, allocator, input, options);
    }

    /// Updates the schema name with a new name. Only development schema names can
    /// be
    /// updated.
    pub fn updateSchema(self: *Self, allocator: std.mem.Allocator, input: update_schema.UpdateSchemaInput, options: update_schema.Options) !update_schema.UpdateSchemaOutput {
        return update_schema.execute(self, allocator, input, options);
    }

    /// Updates a TypedLinkFacet. For more information, see [Typed
    /// Links](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_links.html#directory_objects_links_typedlink).
    pub fn updateTypedLinkFacet(self: *Self, allocator: std.mem.Allocator, input: update_typed_link_facet.UpdateTypedLinkFacetInput, options: update_typed_link_facet.Options) !update_typed_link_facet.UpdateTypedLinkFacetOutput {
        return update_typed_link_facet.execute(self, allocator, input, options);
    }

    /// Upgrades a single directory in-place using the `PublishedSchemaArn` with
    /// schema updates found in `MinorVersion`. Backwards-compatible minor version
    /// upgrades are instantaneously available for readers on all objects in the
    /// directory. Note: This is a synchronous API call and upgrades only one schema
    /// on a given directory per call. To upgrade multiple directories from one
    /// schema, you would need to call this API on each directory.
    pub fn upgradeAppliedSchema(self: *Self, allocator: std.mem.Allocator, input: upgrade_applied_schema.UpgradeAppliedSchemaInput, options: upgrade_applied_schema.Options) !upgrade_applied_schema.UpgradeAppliedSchemaOutput {
        return upgrade_applied_schema.execute(self, allocator, input, options);
    }

    /// Upgrades a published schema under a new minor version revision using the
    /// current contents of `DevelopmentSchemaArn`.
    pub fn upgradePublishedSchema(self: *Self, allocator: std.mem.Allocator, input: upgrade_published_schema.UpgradePublishedSchemaInput, options: upgrade_published_schema.Options) !upgrade_published_schema.UpgradePublishedSchemaOutput {
        return upgrade_published_schema.execute(self, allocator, input, options);
    }

    pub fn listAppliedSchemaArnsPaginator(self: *Self, params: list_applied_schema_arns.ListAppliedSchemaArnsInput) paginator.ListAppliedSchemaArnsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAttachedIndicesPaginator(self: *Self, params: list_attached_indices.ListAttachedIndicesInput) paginator.ListAttachedIndicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevelopmentSchemaArnsPaginator(self: *Self, params: list_development_schema_arns.ListDevelopmentSchemaArnsInput) paginator.ListDevelopmentSchemaArnsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDirectoriesPaginator(self: *Self, params: list_directories.ListDirectoriesInput) paginator.ListDirectoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFacetAttributesPaginator(self: *Self, params: list_facet_attributes.ListFacetAttributesInput) paginator.ListFacetAttributesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFacetNamesPaginator(self: *Self, params: list_facet_names.ListFacetNamesInput) paginator.ListFacetNamesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIndexPaginator(self: *Self, params: list_index.ListIndexInput) paginator.ListIndexPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedSchemaArnsPaginator(self: *Self, params: list_managed_schema_arns.ListManagedSchemaArnsInput) paginator.ListManagedSchemaArnsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listObjectAttributesPaginator(self: *Self, params: list_object_attributes.ListObjectAttributesInput) paginator.ListObjectAttributesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listObjectChildrenPaginator(self: *Self, params: list_object_children.ListObjectChildrenInput) paginator.ListObjectChildrenPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listObjectParentPathsPaginator(self: *Self, params: list_object_parent_paths.ListObjectParentPathsInput) paginator.ListObjectParentPathsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listObjectParentsPaginator(self: *Self, params: list_object_parents.ListObjectParentsInput) paginator.ListObjectParentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listObjectPoliciesPaginator(self: *Self, params: list_object_policies.ListObjectPoliciesInput) paginator.ListObjectPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPolicyAttachmentsPaginator(self: *Self, params: list_policy_attachments.ListPolicyAttachmentsInput) paginator.ListPolicyAttachmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPublishedSchemaArnsPaginator(self: *Self, params: list_published_schema_arns.ListPublishedSchemaArnsInput) paginator.ListPublishedSchemaArnsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTypedLinkFacetAttributesPaginator(self: *Self, params: list_typed_link_facet_attributes.ListTypedLinkFacetAttributesInput) paginator.ListTypedLinkFacetAttributesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTypedLinkFacetNamesPaginator(self: *Self, params: list_typed_link_facet_names.ListTypedLinkFacetNamesInput) paginator.ListTypedLinkFacetNamesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn lookupPolicyPaginator(self: *Self, params: lookup_policy.LookupPolicyInput) paginator.LookupPolicyPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
