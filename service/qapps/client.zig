const aws = @import("aws");
const std = @import("std");

const associate_library_item_review = @import("associate_library_item_review.zig");
const associate_q_app_with_user = @import("associate_q_app_with_user.zig");
const batch_create_category = @import("batch_create_category.zig");
const batch_delete_category = @import("batch_delete_category.zig");
const batch_update_category = @import("batch_update_category.zig");
const create_library_item = @import("create_library_item.zig");
const create_presigned_url = @import("create_presigned_url.zig");
const create_q_app = @import("create_q_app.zig");
const delete_library_item = @import("delete_library_item.zig");
const delete_q_app = @import("delete_q_app.zig");
const describe_q_app_permissions = @import("describe_q_app_permissions.zig");
const disassociate_library_item_review = @import("disassociate_library_item_review.zig");
const disassociate_q_app_from_user = @import("disassociate_q_app_from_user.zig");
const export_q_app_session_data = @import("export_q_app_session_data.zig");
const get_library_item = @import("get_library_item.zig");
const get_q_app = @import("get_q_app.zig");
const get_q_app_session = @import("get_q_app_session.zig");
const get_q_app_session_metadata = @import("get_q_app_session_metadata.zig");
const import_document = @import("import_document.zig");
const list_categories = @import("list_categories.zig");
const list_library_items = @import("list_library_items.zig");
const list_q_app_session_data = @import("list_q_app_session_data.zig");
const list_q_apps = @import("list_q_apps.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const predict_q_app = @import("predict_q_app.zig");
const start_q_app_session = @import("start_q_app_session.zig");
const stop_q_app_session = @import("stop_q_app_session.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_library_item = @import("update_library_item.zig");
const update_library_item_metadata = @import("update_library_item_metadata.zig");
const update_q_app = @import("update_q_app.zig");
const update_q_app_permissions = @import("update_q_app_permissions.zig");
const update_q_app_session = @import("update_q_app_session.zig");
const update_q_app_session_metadata = @import("update_q_app_session_metadata.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "QApps";

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

    /// Associates a rating or review for a library item with the user submitting
    /// the request. This increments the rating count for the specified library
    /// item.
    pub fn associateLibraryItemReview(self: *Self, allocator: std.mem.Allocator, input: associate_library_item_review.AssociateLibraryItemReviewInput, options: CallOptions) !associate_library_item_review.AssociateLibraryItemReviewOutput {
        return associate_library_item_review.execute(self, allocator, input, options);
    }

    /// This operation creates a link between the user's identity calling the
    /// operation and a specific Q App. This is useful to mark the Q App as a
    /// *favorite* for the user if the user doesn't own the Amazon Q App so they can
    /// still run it and see it in their inventory of Q Apps.
    pub fn associateQAppWithUser(self: *Self, allocator: std.mem.Allocator, input: associate_q_app_with_user.AssociateQAppWithUserInput, options: CallOptions) !associate_q_app_with_user.AssociateQAppWithUserOutput {
        return associate_q_app_with_user.execute(self, allocator, input, options);
    }

    /// Creates Categories for the Amazon Q Business application environment
    /// instance. Web experience users use Categories to tag and filter library
    /// items. For more information, see [Custom labels for Amazon Q
    /// Apps](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/qapps-custom-labels.html).
    pub fn batchCreateCategory(self: *Self, allocator: std.mem.Allocator, input: batch_create_category.BatchCreateCategoryInput, options: CallOptions) !batch_create_category.BatchCreateCategoryOutput {
        return batch_create_category.execute(self, allocator, input, options);
    }

    /// Deletes Categories for the Amazon Q Business application environment
    /// instance. Web experience users use Categories to tag and filter library
    /// items. For more information, see [Custom labels for Amazon Q
    /// Apps](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/qapps-custom-labels.html).
    pub fn batchDeleteCategory(self: *Self, allocator: std.mem.Allocator, input: batch_delete_category.BatchDeleteCategoryInput, options: CallOptions) !batch_delete_category.BatchDeleteCategoryOutput {
        return batch_delete_category.execute(self, allocator, input, options);
    }

    /// Updates Categories for the Amazon Q Business application environment
    /// instance. Web experience users use Categories to tag and filter library
    /// items. For more information, see [Custom labels for Amazon Q
    /// Apps](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/qapps-custom-labels.html).
    pub fn batchUpdateCategory(self: *Self, allocator: std.mem.Allocator, input: batch_update_category.BatchUpdateCategoryInput, options: CallOptions) !batch_update_category.BatchUpdateCategoryOutput {
        return batch_update_category.execute(self, allocator, input, options);
    }

    /// Creates a new library item for an Amazon Q App, allowing it to be discovered
    /// and used by other allowed users.
    pub fn createLibraryItem(self: *Self, allocator: std.mem.Allocator, input: create_library_item.CreateLibraryItemInput, options: CallOptions) !create_library_item.CreateLibraryItemOutput {
        return create_library_item.execute(self, allocator, input, options);
    }

    /// Creates a presigned URL for an S3 POST operation to upload a file. You can
    /// use this URL to set a default file for a `FileUploadCard` in a Q App
    /// definition or to provide a file for a single Q App run. The `scope`
    /// parameter determines how the file will be used, either at the app definition
    /// level or the app session level.
    ///
    /// The IAM permissions are derived from the `qapps:ImportDocument` action. For
    /// more information on the IAM policy for Amazon Q Apps, see [IAM permissions
    /// for using Amazon Q
    /// Apps](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/deploy-q-apps-iam-permissions.html).
    pub fn createPresignedUrl(self: *Self, allocator: std.mem.Allocator, input: create_presigned_url.CreatePresignedUrlInput, options: CallOptions) !create_presigned_url.CreatePresignedUrlOutput {
        return create_presigned_url.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Q App based on the provided definition. The Q App
    /// definition specifies the cards and flow of the Q App. This operation also
    /// calculates the dependencies between the cards by inspecting the references
    /// in the prompts.
    pub fn createQApp(self: *Self, allocator: std.mem.Allocator, input: create_q_app.CreateQAppInput, options: CallOptions) !create_q_app.CreateQAppOutput {
        return create_q_app.execute(self, allocator, input, options);
    }

    /// Deletes a library item for an Amazon Q App, removing it from the library so
    /// it can no longer be discovered or used by other users.
    pub fn deleteLibraryItem(self: *Self, allocator: std.mem.Allocator, input: delete_library_item.DeleteLibraryItemInput, options: CallOptions) !delete_library_item.DeleteLibraryItemOutput {
        return delete_library_item.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Q App owned by the user. If the Q App was previously
    /// published to the library, it is also removed from the library.
    pub fn deleteQApp(self: *Self, allocator: std.mem.Allocator, input: delete_q_app.DeleteQAppInput, options: CallOptions) !delete_q_app.DeleteQAppOutput {
        return delete_q_app.execute(self, allocator, input, options);
    }

    /// Describes read permissions for a Amazon Q App in Amazon Q Business
    /// application environment instance.
    pub fn describeQAppPermissions(self: *Self, allocator: std.mem.Allocator, input: describe_q_app_permissions.DescribeQAppPermissionsInput, options: CallOptions) !describe_q_app_permissions.DescribeQAppPermissionsOutput {
        return describe_q_app_permissions.execute(self, allocator, input, options);
    }

    /// Removes a rating or review previously submitted by the user for a library
    /// item.
    pub fn disassociateLibraryItemReview(self: *Self, allocator: std.mem.Allocator, input: disassociate_library_item_review.DisassociateLibraryItemReviewInput, options: CallOptions) !disassociate_library_item_review.DisassociateLibraryItemReviewOutput {
        return disassociate_library_item_review.execute(self, allocator, input, options);
    }

    /// Disassociates a Q App from a user removing the user's access to run the Q
    /// App.
    pub fn disassociateQAppFromUser(self: *Self, allocator: std.mem.Allocator, input: disassociate_q_app_from_user.DisassociateQAppFromUserInput, options: CallOptions) !disassociate_q_app_from_user.DisassociateQAppFromUserOutput {
        return disassociate_q_app_from_user.execute(self, allocator, input, options);
    }

    /// Exports the collected data of a Q App data collection session.
    pub fn exportQAppSessionData(self: *Self, allocator: std.mem.Allocator, input: export_q_app_session_data.ExportQAppSessionDataInput, options: CallOptions) !export_q_app_session_data.ExportQAppSessionDataOutput {
        return export_q_app_session_data.execute(self, allocator, input, options);
    }

    /// Retrieves details about a library item for an Amazon Q App, including its
    /// metadata, categories, ratings, and usage statistics.
    pub fn getLibraryItem(self: *Self, allocator: std.mem.Allocator, input: get_library_item.GetLibraryItemInput, options: CallOptions) !get_library_item.GetLibraryItemOutput {
        return get_library_item.execute(self, allocator, input, options);
    }

    /// Retrieves the full details of an Q App, including its definition specifying
    /// the cards and flow.
    pub fn getQApp(self: *Self, allocator: std.mem.Allocator, input: get_q_app.GetQAppInput, options: CallOptions) !get_q_app.GetQAppOutput {
        return get_q_app.execute(self, allocator, input, options);
    }

    /// Retrieves the current state and results for an active session of an Amazon Q
    /// App.
    pub fn getQAppSession(self: *Self, allocator: std.mem.Allocator, input: get_q_app_session.GetQAppSessionInput, options: CallOptions) !get_q_app_session.GetQAppSessionOutput {
        return get_q_app_session.execute(self, allocator, input, options);
    }

    /// Retrieves the current configuration of a Q App session.
    pub fn getQAppSessionMetadata(self: *Self, allocator: std.mem.Allocator, input: get_q_app_session_metadata.GetQAppSessionMetadataInput, options: CallOptions) !get_q_app_session_metadata.GetQAppSessionMetadataOutput {
        return get_q_app_session_metadata.execute(self, allocator, input, options);
    }

    /// Uploads a file that can then be used either as a default in a
    /// `FileUploadCard` from Q App definition or as a file that is used inside a
    /// single Q App run. The purpose of the document is determined by a scope
    /// parameter that indicates whether it is at the app definition level or at the
    /// app session level.
    pub fn importDocument(self: *Self, allocator: std.mem.Allocator, input: import_document.ImportDocumentInput, options: CallOptions) !import_document.ImportDocumentOutput {
        return import_document.execute(self, allocator, input, options);
    }

    /// Lists the categories of a Amazon Q Business application environment
    /// instance. For more information, see [Custom labels for Amazon Q
    /// Apps](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/qapps-custom-labels.html).
    pub fn listCategories(self: *Self, allocator: std.mem.Allocator, input: list_categories.ListCategoriesInput, options: CallOptions) !list_categories.ListCategoriesOutput {
        return list_categories.execute(self, allocator, input, options);
    }

    /// Lists the library items for Amazon Q Apps that are published and available
    /// for users in your Amazon Web Services account.
    pub fn listLibraryItems(self: *Self, allocator: std.mem.Allocator, input: list_library_items.ListLibraryItemsInput, options: CallOptions) !list_library_items.ListLibraryItemsOutput {
        return list_library_items.execute(self, allocator, input, options);
    }

    /// Lists the collected data of a Q App data collection session.
    pub fn listQAppSessionData(self: *Self, allocator: std.mem.Allocator, input: list_q_app_session_data.ListQAppSessionDataInput, options: CallOptions) !list_q_app_session_data.ListQAppSessionDataOutput {
        return list_q_app_session_data.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Q Apps owned by or associated with the user either because
    /// they created it or because they used it from the library in the past. The
    /// user identity is extracted from the credentials used to invoke this
    /// operation..
    pub fn listQApps(self: *Self, allocator: std.mem.Allocator, input: list_q_apps.ListQAppsInput, options: CallOptions) !list_q_apps.ListQAppsOutput {
        return list_q_apps.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with an Amazon Q Apps resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Generates an Amazon Q App definition based on either a conversation or a
    /// problem statement provided as input.The resulting app definition can be used
    /// to call `CreateQApp`. This API doesn't create Amazon Q Apps directly.
    pub fn predictQApp(self: *Self, allocator: std.mem.Allocator, input: predict_q_app.PredictQAppInput, options: CallOptions) !predict_q_app.PredictQAppOutput {
        return predict_q_app.execute(self, allocator, input, options);
    }

    /// Starts a new session for an Amazon Q App, allowing inputs to be provided and
    /// the app to be run.
    ///
    /// Each Q App session will be condensed into a single conversation in the web
    /// experience.
    pub fn startQAppSession(self: *Self, allocator: std.mem.Allocator, input: start_q_app_session.StartQAppSessionInput, options: CallOptions) !start_q_app_session.StartQAppSessionOutput {
        return start_q_app_session.execute(self, allocator, input, options);
    }

    /// Stops an active session for an Amazon Q App.This deletes all data related to
    /// the session and makes it invalid for future uses. The results of the session
    /// will be persisted as part of the conversation.
    pub fn stopQAppSession(self: *Self, allocator: std.mem.Allocator, input: stop_q_app_session.StopQAppSessionInput, options: CallOptions) !stop_q_app_session.StopQAppSessionOutput {
        return stop_q_app_session.execute(self, allocator, input, options);
    }

    /// Associates tags with an Amazon Q Apps resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Disassociates tags from an Amazon Q Apps resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the library item for an Amazon Q App.
    pub fn updateLibraryItem(self: *Self, allocator: std.mem.Allocator, input: update_library_item.UpdateLibraryItemInput, options: CallOptions) !update_library_item.UpdateLibraryItemOutput {
        return update_library_item.execute(self, allocator, input, options);
    }

    /// Updates the verification status of a library item for an Amazon Q App.
    pub fn updateLibraryItemMetadata(self: *Self, allocator: std.mem.Allocator, input: update_library_item_metadata.UpdateLibraryItemMetadataInput, options: CallOptions) !update_library_item_metadata.UpdateLibraryItemMetadataOutput {
        return update_library_item_metadata.execute(self, allocator, input, options);
    }

    /// Updates an existing Amazon Q App, allowing modifications to its title,
    /// description, and definition.
    pub fn updateQApp(self: *Self, allocator: std.mem.Allocator, input: update_q_app.UpdateQAppInput, options: CallOptions) !update_q_app.UpdateQAppOutput {
        return update_q_app.execute(self, allocator, input, options);
    }

    /// Updates read permissions for a Amazon Q App in Amazon Q Business application
    /// environment instance.
    pub fn updateQAppPermissions(self: *Self, allocator: std.mem.Allocator, input: update_q_app_permissions.UpdateQAppPermissionsInput, options: CallOptions) !update_q_app_permissions.UpdateQAppPermissionsOutput {
        return update_q_app_permissions.execute(self, allocator, input, options);
    }

    /// Updates the session for a given Q App `sessionId`. This is only valid when
    /// at least one card of the session is in the `WAITING` state. Data for each
    /// `WAITING` card can be provided as input. If inputs are not provided, the
    /// call will be accepted but session will not move forward. Inputs for cards
    /// that are not in the `WAITING` status will be ignored.
    pub fn updateQAppSession(self: *Self, allocator: std.mem.Allocator, input: update_q_app_session.UpdateQAppSessionInput, options: CallOptions) !update_q_app_session.UpdateQAppSessionOutput {
        return update_q_app_session.execute(self, allocator, input, options);
    }

    /// Updates the configuration metadata of a session for a given Q App
    /// `sessionId`.
    pub fn updateQAppSessionMetadata(self: *Self, allocator: std.mem.Allocator, input: update_q_app_session_metadata.UpdateQAppSessionMetadataInput, options: CallOptions) !update_q_app_session_metadata.UpdateQAppSessionMetadataOutput {
        return update_q_app_session_metadata.execute(self, allocator, input, options);
    }

    pub fn listLibraryItemsPaginator(self: *Self, params: list_library_items.ListLibraryItemsInput) paginator.ListLibraryItemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listQAppsPaginator(self: *Self, params: list_q_apps.ListQAppsInput) paginator.ListQAppsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
