const aws = @import("aws");
const std = @import("std");

const abort_document_version_upload = @import("abort_document_version_upload.zig");
const activate_user = @import("activate_user.zig");
const add_resource_permissions = @import("add_resource_permissions.zig");
const create_comment = @import("create_comment.zig");
const create_custom_metadata = @import("create_custom_metadata.zig");
const create_folder = @import("create_folder.zig");
const create_labels = @import("create_labels.zig");
const create_notification_subscription = @import("create_notification_subscription.zig");
const create_user = @import("create_user.zig");
const deactivate_user = @import("deactivate_user.zig");
const delete_comment = @import("delete_comment.zig");
const delete_custom_metadata = @import("delete_custom_metadata.zig");
const delete_document = @import("delete_document.zig");
const delete_document_version = @import("delete_document_version.zig");
const delete_folder = @import("delete_folder.zig");
const delete_folder_contents = @import("delete_folder_contents.zig");
const delete_labels = @import("delete_labels.zig");
const delete_notification_subscription = @import("delete_notification_subscription.zig");
const delete_user = @import("delete_user.zig");
const describe_activities = @import("describe_activities.zig");
const describe_comments = @import("describe_comments.zig");
const describe_document_versions = @import("describe_document_versions.zig");
const describe_folder_contents = @import("describe_folder_contents.zig");
const describe_groups = @import("describe_groups.zig");
const describe_notification_subscriptions = @import("describe_notification_subscriptions.zig");
const describe_resource_permissions = @import("describe_resource_permissions.zig");
const describe_root_folders = @import("describe_root_folders.zig");
const describe_users = @import("describe_users.zig");
const get_current_user = @import("get_current_user.zig");
const get_document = @import("get_document.zig");
const get_document_path = @import("get_document_path.zig");
const get_document_version = @import("get_document_version.zig");
const get_folder = @import("get_folder.zig");
const get_folder_path = @import("get_folder_path.zig");
const get_resources = @import("get_resources.zig");
const initiate_document_version_upload = @import("initiate_document_version_upload.zig");
const remove_all_resource_permissions = @import("remove_all_resource_permissions.zig");
const remove_resource_permission = @import("remove_resource_permission.zig");
const restore_document_versions = @import("restore_document_versions.zig");
const search_resources = @import("search_resources.zig");
const update_document = @import("update_document.zig");
const update_document_version = @import("update_document_version.zig");
const update_folder = @import("update_folder.zig");
const update_user = @import("update_user.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "WorkDocs";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Aborts the upload of the specified document version that was previously
    /// initiated
    /// by InitiateDocumentVersionUpload. The client should make this call
    /// only when it no longer intends to upload the document version, or fails to
    /// do
    /// so.
    pub fn abortDocumentVersionUpload(self: *Self, allocator: std.mem.Allocator, input: abort_document_version_upload.AbortDocumentVersionUploadInput, options: CallOptions) !abort_document_version_upload.AbortDocumentVersionUploadOutput {
        return abort_document_version_upload.execute(self, allocator, input, options);
    }

    /// Activates the specified user. Only active users can access Amazon
    /// WorkDocs.
    pub fn activateUser(self: *Self, allocator: std.mem.Allocator, input: activate_user.ActivateUserInput, options: CallOptions) !activate_user.ActivateUserOutput {
        return activate_user.execute(self, allocator, input, options);
    }

    /// Creates a set of permissions for the specified folder or document. The
    /// resource
    /// permissions are overwritten if the principals already have different
    /// permissions.
    pub fn addResourcePermissions(self: *Self, allocator: std.mem.Allocator, input: add_resource_permissions.AddResourcePermissionsInput, options: CallOptions) !add_resource_permissions.AddResourcePermissionsOutput {
        return add_resource_permissions.execute(self, allocator, input, options);
    }

    /// Adds a new comment to the specified document version.
    pub fn createComment(self: *Self, allocator: std.mem.Allocator, input: create_comment.CreateCommentInput, options: CallOptions) !create_comment.CreateCommentOutput {
        return create_comment.execute(self, allocator, input, options);
    }

    /// Adds one or more custom properties to the specified resource (a folder,
    /// document,
    /// or version).
    pub fn createCustomMetadata(self: *Self, allocator: std.mem.Allocator, input: create_custom_metadata.CreateCustomMetadataInput, options: CallOptions) !create_custom_metadata.CreateCustomMetadataOutput {
        return create_custom_metadata.execute(self, allocator, input, options);
    }

    /// Creates a folder with the specified name and parent folder.
    pub fn createFolder(self: *Self, allocator: std.mem.Allocator, input: create_folder.CreateFolderInput, options: CallOptions) !create_folder.CreateFolderOutput {
        return create_folder.execute(self, allocator, input, options);
    }

    /// Adds the specified list of labels to the given resource (a document or
    /// folder)
    pub fn createLabels(self: *Self, allocator: std.mem.Allocator, input: create_labels.CreateLabelsInput, options: CallOptions) !create_labels.CreateLabelsOutput {
        return create_labels.execute(self, allocator, input, options);
    }

    /// Configure Amazon WorkDocs to use Amazon SNS notifications. The endpoint
    /// receives a
    /// confirmation message, and must confirm the subscription.
    ///
    /// For more information, see [Setting up notifications for an IAM user or
    /// role](https://docs.aws.amazon.com/workdocs/latest/developerguide/manage-notifications.html) in the *Amazon WorkDocs Developer
    /// Guide*.
    pub fn createNotificationSubscription(self: *Self, allocator: std.mem.Allocator, input: create_notification_subscription.CreateNotificationSubscriptionInput, options: CallOptions) !create_notification_subscription.CreateNotificationSubscriptionOutput {
        return create_notification_subscription.execute(self, allocator, input, options);
    }

    /// Creates a user in a Simple AD or Microsoft AD directory. The status of a
    /// newly
    /// created user is "ACTIVE". New users can access Amazon WorkDocs.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: CallOptions) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Deactivates the specified user, which revokes the user's access to Amazon
    /// WorkDocs.
    pub fn deactivateUser(self: *Self, allocator: std.mem.Allocator, input: deactivate_user.DeactivateUserInput, options: CallOptions) !deactivate_user.DeactivateUserOutput {
        return deactivate_user.execute(self, allocator, input, options);
    }

    /// Deletes the specified comment from the document version.
    pub fn deleteComment(self: *Self, allocator: std.mem.Allocator, input: delete_comment.DeleteCommentInput, options: CallOptions) !delete_comment.DeleteCommentOutput {
        return delete_comment.execute(self, allocator, input, options);
    }

    /// Deletes custom metadata from the specified resource.
    pub fn deleteCustomMetadata(self: *Self, allocator: std.mem.Allocator, input: delete_custom_metadata.DeleteCustomMetadataInput, options: CallOptions) !delete_custom_metadata.DeleteCustomMetadataOutput {
        return delete_custom_metadata.execute(self, allocator, input, options);
    }

    /// Permanently deletes the specified document and its associated metadata.
    pub fn deleteDocument(self: *Self, allocator: std.mem.Allocator, input: delete_document.DeleteDocumentInput, options: CallOptions) !delete_document.DeleteDocumentOutput {
        return delete_document.execute(self, allocator, input, options);
    }

    /// Deletes a specific version of a document.
    pub fn deleteDocumentVersion(self: *Self, allocator: std.mem.Allocator, input: delete_document_version.DeleteDocumentVersionInput, options: CallOptions) !delete_document_version.DeleteDocumentVersionOutput {
        return delete_document_version.execute(self, allocator, input, options);
    }

    /// Permanently deletes the specified folder and its contents.
    pub fn deleteFolder(self: *Self, allocator: std.mem.Allocator, input: delete_folder.DeleteFolderInput, options: CallOptions) !delete_folder.DeleteFolderOutput {
        return delete_folder.execute(self, allocator, input, options);
    }

    /// Deletes the contents of the specified folder.
    pub fn deleteFolderContents(self: *Self, allocator: std.mem.Allocator, input: delete_folder_contents.DeleteFolderContentsInput, options: CallOptions) !delete_folder_contents.DeleteFolderContentsOutput {
        return delete_folder_contents.execute(self, allocator, input, options);
    }

    /// Deletes the specified list of labels from a resource.
    pub fn deleteLabels(self: *Self, allocator: std.mem.Allocator, input: delete_labels.DeleteLabelsInput, options: CallOptions) !delete_labels.DeleteLabelsOutput {
        return delete_labels.execute(self, allocator, input, options);
    }

    /// Deletes the specified subscription from the specified organization.
    pub fn deleteNotificationSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_notification_subscription.DeleteNotificationSubscriptionInput, options: CallOptions) !delete_notification_subscription.DeleteNotificationSubscriptionOutput {
        return delete_notification_subscription.execute(self, allocator, input, options);
    }

    /// Deletes the specified user from a Simple AD or Microsoft AD directory.
    ///
    /// Deleting a user immediately and permanently deletes all content in that
    /// user's folder structure. Site retention policies do NOT apply to this type
    /// of deletion.
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: CallOptions) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Describes the user activities in a specified time period.
    pub fn describeActivities(self: *Self, allocator: std.mem.Allocator, input: describe_activities.DescribeActivitiesInput, options: CallOptions) !describe_activities.DescribeActivitiesOutput {
        return describe_activities.execute(self, allocator, input, options);
    }

    /// List all the comments for the specified document version.
    pub fn describeComments(self: *Self, allocator: std.mem.Allocator, input: describe_comments.DescribeCommentsInput, options: CallOptions) !describe_comments.DescribeCommentsOutput {
        return describe_comments.execute(self, allocator, input, options);
    }

    /// Retrieves the document versions for the specified document.
    ///
    /// By default, only active versions are returned.
    pub fn describeDocumentVersions(self: *Self, allocator: std.mem.Allocator, input: describe_document_versions.DescribeDocumentVersionsInput, options: CallOptions) !describe_document_versions.DescribeDocumentVersionsOutput {
        return describe_document_versions.execute(self, allocator, input, options);
    }

    /// Describes the contents of the specified folder, including its documents and
    /// subfolders.
    ///
    /// By default, Amazon WorkDocs returns the first 100 active document and folder
    /// metadata items. If there are more results, the response includes a marker
    /// that you can
    /// use to request the next set of results. You can also request initialized
    /// documents.
    pub fn describeFolderContents(self: *Self, allocator: std.mem.Allocator, input: describe_folder_contents.DescribeFolderContentsInput, options: CallOptions) !describe_folder_contents.DescribeFolderContentsOutput {
        return describe_folder_contents.execute(self, allocator, input, options);
    }

    /// Describes the groups specified by the query. Groups are defined by the
    /// underlying
    /// Active Directory.
    pub fn describeGroups(self: *Self, allocator: std.mem.Allocator, input: describe_groups.DescribeGroupsInput, options: CallOptions) !describe_groups.DescribeGroupsOutput {
        return describe_groups.execute(self, allocator, input, options);
    }

    /// Lists the specified notification subscriptions.
    pub fn describeNotificationSubscriptions(self: *Self, allocator: std.mem.Allocator, input: describe_notification_subscriptions.DescribeNotificationSubscriptionsInput, options: CallOptions) !describe_notification_subscriptions.DescribeNotificationSubscriptionsOutput {
        return describe_notification_subscriptions.execute(self, allocator, input, options);
    }

    /// Describes the permissions of a specified resource.
    pub fn describeResourcePermissions(self: *Self, allocator: std.mem.Allocator, input: describe_resource_permissions.DescribeResourcePermissionsInput, options: CallOptions) !describe_resource_permissions.DescribeResourcePermissionsOutput {
        return describe_resource_permissions.execute(self, allocator, input, options);
    }

    /// Describes the current user's special folders; the `RootFolder` and the
    /// `RecycleBin`. `RootFolder` is the root of user's files and
    /// folders and `RecycleBin` is the root of recycled items. This is not a valid
    /// action for SigV4 (administrative API) clients.
    ///
    /// This action requires an authentication token. To get an authentication
    /// token,
    /// register an application with Amazon WorkDocs. For more information, see
    /// [Authentication and Access
    /// Control for User
    /// Applications](https://docs.aws.amazon.com/workdocs/latest/developerguide/wd-auth-user.html) in the
    /// *Amazon
    /// WorkDocs Developer Guide*.
    pub fn describeRootFolders(self: *Self, allocator: std.mem.Allocator, input: describe_root_folders.DescribeRootFoldersInput, options: CallOptions) !describe_root_folders.DescribeRootFoldersOutput {
        return describe_root_folders.execute(self, allocator, input, options);
    }

    /// Describes the specified users. You can describe all users or filter the
    /// results
    /// (for example, by status or organization).
    ///
    /// By default, Amazon WorkDocs returns the first 24 active or pending users. If
    /// there
    /// are more results, the response includes a marker that you can use to request
    /// the next
    /// set of results.
    pub fn describeUsers(self: *Self, allocator: std.mem.Allocator, input: describe_users.DescribeUsersInput, options: CallOptions) !describe_users.DescribeUsersOutput {
        return describe_users.execute(self, allocator, input, options);
    }

    /// Retrieves details of the current user for whom the authentication token was
    /// generated. This is not a valid action for SigV4 (administrative API)
    /// clients.
    ///
    /// This action requires an authentication token. To get an authentication
    /// token,
    /// register an application with Amazon WorkDocs. For more information, see
    /// [Authentication and Access
    /// Control for User
    /// Applications](https://docs.aws.amazon.com/workdocs/latest/developerguide/wd-auth-user.html) in the
    /// *Amazon
    /// WorkDocs Developer Guide*.
    pub fn getCurrentUser(self: *Self, allocator: std.mem.Allocator, input: get_current_user.GetCurrentUserInput, options: CallOptions) !get_current_user.GetCurrentUserOutput {
        return get_current_user.execute(self, allocator, input, options);
    }

    /// Retrieves details of a document.
    pub fn getDocument(self: *Self, allocator: std.mem.Allocator, input: get_document.GetDocumentInput, options: CallOptions) !get_document.GetDocumentOutput {
        return get_document.execute(self, allocator, input, options);
    }

    /// Retrieves the path information (the hierarchy from the root folder) for the
    /// requested document.
    ///
    /// By default, Amazon WorkDocs returns a maximum of 100 levels upwards from the
    /// requested document and only includes the IDs of the parent folders in the
    /// path. You can
    /// limit the maximum number of levels. You can also request the names of the
    /// parent
    /// folders.
    pub fn getDocumentPath(self: *Self, allocator: std.mem.Allocator, input: get_document_path.GetDocumentPathInput, options: CallOptions) !get_document_path.GetDocumentPathOutput {
        return get_document_path.execute(self, allocator, input, options);
    }

    /// Retrieves version metadata for the specified document.
    pub fn getDocumentVersion(self: *Self, allocator: std.mem.Allocator, input: get_document_version.GetDocumentVersionInput, options: CallOptions) !get_document_version.GetDocumentVersionOutput {
        return get_document_version.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata of the specified folder.
    pub fn getFolder(self: *Self, allocator: std.mem.Allocator, input: get_folder.GetFolderInput, options: CallOptions) !get_folder.GetFolderOutput {
        return get_folder.execute(self, allocator, input, options);
    }

    /// Retrieves the path information (the hierarchy from the root folder) for the
    /// specified folder.
    ///
    /// By default, Amazon WorkDocs returns a maximum of 100 levels upwards from the
    /// requested folder and only includes the IDs of the parent folders in the
    /// path. You can
    /// limit the maximum number of levels. You can also request the parent folder
    /// names.
    pub fn getFolderPath(self: *Self, allocator: std.mem.Allocator, input: get_folder_path.GetFolderPathInput, options: CallOptions) !get_folder_path.GetFolderPathOutput {
        return get_folder_path.execute(self, allocator, input, options);
    }

    /// Retrieves a collection of resources, including folders and documents. The
    /// only
    /// `CollectionType` supported is `SHARED_WITH_ME`.
    pub fn getResources(self: *Self, allocator: std.mem.Allocator, input: get_resources.GetResourcesInput, options: CallOptions) !get_resources.GetResourcesOutput {
        return get_resources.execute(self, allocator, input, options);
    }

    /// Creates a new document object and version object.
    ///
    /// The client specifies the parent folder ID and name of the document to
    /// upload. The
    /// ID is optionally specified when creating a new version of an existing
    /// document. This is
    /// the first step to upload a document. Next, upload the document to the URL
    /// returned from
    /// the call, and then call UpdateDocumentVersion.
    ///
    /// To cancel the document upload, call AbortDocumentVersionUpload.
    pub fn initiateDocumentVersionUpload(self: *Self, allocator: std.mem.Allocator, input: initiate_document_version_upload.InitiateDocumentVersionUploadInput, options: CallOptions) !initiate_document_version_upload.InitiateDocumentVersionUploadOutput {
        return initiate_document_version_upload.execute(self, allocator, input, options);
    }

    /// Removes all the permissions from the specified resource.
    pub fn removeAllResourcePermissions(self: *Self, allocator: std.mem.Allocator, input: remove_all_resource_permissions.RemoveAllResourcePermissionsInput, options: CallOptions) !remove_all_resource_permissions.RemoveAllResourcePermissionsOutput {
        return remove_all_resource_permissions.execute(self, allocator, input, options);
    }

    /// Removes the permission for the specified principal from the specified
    /// resource.
    pub fn removeResourcePermission(self: *Self, allocator: std.mem.Allocator, input: remove_resource_permission.RemoveResourcePermissionInput, options: CallOptions) !remove_resource_permission.RemoveResourcePermissionOutput {
        return remove_resource_permission.execute(self, allocator, input, options);
    }

    /// Recovers a deleted version of an Amazon WorkDocs document.
    pub fn restoreDocumentVersions(self: *Self, allocator: std.mem.Allocator, input: restore_document_versions.RestoreDocumentVersionsInput, options: CallOptions) !restore_document_versions.RestoreDocumentVersionsOutput {
        return restore_document_versions.execute(self, allocator, input, options);
    }

    /// Searches metadata and the content of folders, documents, document versions,
    /// and comments.
    pub fn searchResources(self: *Self, allocator: std.mem.Allocator, input: search_resources.SearchResourcesInput, options: CallOptions) !search_resources.SearchResourcesOutput {
        return search_resources.execute(self, allocator, input, options);
    }

    /// Updates the specified attributes of a document. The user must have access to
    /// both
    /// the document and its parent folder, if applicable.
    pub fn updateDocument(self: *Self, allocator: std.mem.Allocator, input: update_document.UpdateDocumentInput, options: CallOptions) !update_document.UpdateDocumentOutput {
        return update_document.execute(self, allocator, input, options);
    }

    /// Changes the status of the document version to ACTIVE.
    ///
    /// Amazon WorkDocs also sets its document container to ACTIVE. This is the last
    /// step
    /// in a document upload, after the client uploads the document to an
    /// S3-presigned URL
    /// returned by InitiateDocumentVersionUpload.
    pub fn updateDocumentVersion(self: *Self, allocator: std.mem.Allocator, input: update_document_version.UpdateDocumentVersionInput, options: CallOptions) !update_document_version.UpdateDocumentVersionOutput {
        return update_document_version.execute(self, allocator, input, options);
    }

    /// Updates the specified attributes of the specified folder. The user must have
    /// access
    /// to both the folder and its parent folder, if applicable.
    pub fn updateFolder(self: *Self, allocator: std.mem.Allocator, input: update_folder.UpdateFolderInput, options: CallOptions) !update_folder.UpdateFolderOutput {
        return update_folder.execute(self, allocator, input, options);
    }

    /// Updates the specified attributes of the specified user, and grants or
    /// revokes
    /// administrative privileges to the Amazon WorkDocs site.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: CallOptions) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    pub fn describeActivitiesPaginator(self: *Self, params: describe_activities.DescribeActivitiesInput) paginator.DescribeActivitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCommentsPaginator(self: *Self, params: describe_comments.DescribeCommentsInput) paginator.DescribeCommentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDocumentVersionsPaginator(self: *Self, params: describe_document_versions.DescribeDocumentVersionsInput) paginator.DescribeDocumentVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFolderContentsPaginator(self: *Self, params: describe_folder_contents.DescribeFolderContentsInput) paginator.DescribeFolderContentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeGroupsPaginator(self: *Self, params: describe_groups.DescribeGroupsInput) paginator.DescribeGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNotificationSubscriptionsPaginator(self: *Self, params: describe_notification_subscriptions.DescribeNotificationSubscriptionsInput) paginator.DescribeNotificationSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeResourcePermissionsPaginator(self: *Self, params: describe_resource_permissions.DescribeResourcePermissionsInput) paginator.DescribeResourcePermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRootFoldersPaginator(self: *Self, params: describe_root_folders.DescribeRootFoldersInput) paginator.DescribeRootFoldersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeUsersPaginator(self: *Self, params: describe_users.DescribeUsersInput) paginator.DescribeUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchResourcesPaginator(self: *Self, params: search_resources.SearchResourcesInput) paginator.SearchResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
