const aws = @import("aws");
const std = @import("std");

const create_aws_log_source = @import("create_aws_log_source.zig");
const create_custom_log_source = @import("create_custom_log_source.zig");
const create_data_lake = @import("create_data_lake.zig");
const create_data_lake_exception_subscription = @import("create_data_lake_exception_subscription.zig");
const create_data_lake_organization_configuration = @import("create_data_lake_organization_configuration.zig");
const create_subscriber = @import("create_subscriber.zig");
const create_subscriber_notification = @import("create_subscriber_notification.zig");
const delete_aws_log_source = @import("delete_aws_log_source.zig");
const delete_custom_log_source = @import("delete_custom_log_source.zig");
const delete_data_lake = @import("delete_data_lake.zig");
const delete_data_lake_exception_subscription = @import("delete_data_lake_exception_subscription.zig");
const delete_data_lake_organization_configuration = @import("delete_data_lake_organization_configuration.zig");
const delete_subscriber = @import("delete_subscriber.zig");
const delete_subscriber_notification = @import("delete_subscriber_notification.zig");
const deregister_data_lake_delegated_administrator = @import("deregister_data_lake_delegated_administrator.zig");
const get_data_lake_exception_subscription = @import("get_data_lake_exception_subscription.zig");
const get_data_lake_organization_configuration = @import("get_data_lake_organization_configuration.zig");
const get_data_lake_sources = @import("get_data_lake_sources.zig");
const get_subscriber = @import("get_subscriber.zig");
const list_data_lake_exceptions = @import("list_data_lake_exceptions.zig");
const list_data_lakes = @import("list_data_lakes.zig");
const list_log_sources = @import("list_log_sources.zig");
const list_subscribers = @import("list_subscribers.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_data_lake_delegated_administrator = @import("register_data_lake_delegated_administrator.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_data_lake = @import("update_data_lake.zig");
const update_data_lake_exception_subscription = @import("update_data_lake_exception_subscription.zig");
const update_subscriber = @import("update_subscriber.zig");
const update_subscriber_notification = @import("update_subscriber_notification.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SecurityLake";

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

    /// Adds a natively supported Amazon Web Services service as an Amazon Security
    /// Lake source. Enables
    /// source types for member accounts in required Amazon Web Services Regions,
    /// based on the
    /// parameters you specify. You can choose any source type in any Region for
    /// either accounts
    /// that are part of a trusted organization or standalone accounts. Once you add
    /// an Amazon Web Services service as a source, Security Lake starts collecting
    /// logs and events from it.
    ///
    /// You can use this API only to enable natively supported Amazon Web Services
    /// services as a
    /// source. Use `CreateCustomLogSource` to enable data collection from a custom
    /// source.
    pub fn createAwsLogSource(self: *Self, allocator: std.mem.Allocator, input: create_aws_log_source.CreateAwsLogSourceInput, options: create_aws_log_source.Options) !create_aws_log_source.CreateAwsLogSourceOutput {
        return create_aws_log_source.execute(self, allocator, input, options);
    }

    /// Adds a third-party custom source in Amazon Security Lake, from the Amazon
    /// Web Services Region
    /// where you want to create a custom source. Security Lake can collect logs and
    /// events from
    /// third-party custom sources. After creating the appropriate IAM role to
    /// invoke Glue crawler, use this API to add a custom source name in Security
    /// Lake. This
    /// operation creates a partition in the Amazon S3 bucket for Security Lake as
    /// the target
    /// location for log files from the custom source. In addition, this operation
    /// also creates an
    /// associated Glue table and an Glue crawler.
    pub fn createCustomLogSource(self: *Self, allocator: std.mem.Allocator, input: create_custom_log_source.CreateCustomLogSourceInput, options: create_custom_log_source.Options) !create_custom_log_source.CreateCustomLogSourceOutput {
        return create_custom_log_source.execute(self, allocator, input, options);
    }

    /// Initializes an Amazon Security Lake instance with the provided (or default)
    /// configuration. You
    /// can enable Security Lake in Amazon Web Services Regions with customized
    /// settings before enabling
    /// log collection in Regions. To specify particular Regions, configure these
    /// Regions using the
    /// `configurations` parameter. If you have already enabled Security Lake in a
    /// Region
    /// when you call this command, the command will update the Region if you
    /// provide new
    /// configuration parameters. If you have not already enabled Security Lake in
    /// the Region when you
    /// call this API, it will set up the data lake in the Region with the specified
    /// configurations.
    ///
    /// When you enable Security Lake, it starts ingesting security data after the
    /// `CreateAwsLogSource` call and after you create subscribers using the
    /// `CreateSubscriber` API. This includes ingesting security data from
    /// sources, storing data, and making data accessible to subscribers. Security
    /// Lake also enables
    /// all the existing settings and resources that it stores or maintains for your
    /// Amazon Web Services account in the current Region, including security log
    /// and event data. For
    /// more information, see the [Amazon Security Lake User
    /// Guide](https://docs.aws.amazon.com/security-lake/latest/userguide/what-is-security-lake.html).
    pub fn createDataLake(self: *Self, allocator: std.mem.Allocator, input: create_data_lake.CreateDataLakeInput, options: create_data_lake.Options) !create_data_lake.CreateDataLakeOutput {
        return create_data_lake.execute(self, allocator, input, options);
    }

    /// Creates the specified notification subscription in Amazon Security Lake for
    /// the organization
    /// you specify. The notification subscription is created for exceptions that
    /// cannot be resolved by Security Lake automatically.
    pub fn createDataLakeExceptionSubscription(self: *Self, allocator: std.mem.Allocator, input: create_data_lake_exception_subscription.CreateDataLakeExceptionSubscriptionInput, options: create_data_lake_exception_subscription.Options) !create_data_lake_exception_subscription.CreateDataLakeExceptionSubscriptionOutput {
        return create_data_lake_exception_subscription.execute(self, allocator, input, options);
    }

    /// Automatically enables Amazon Security Lake for new member accounts in your
    /// organization.
    /// Security Lake is not automatically enabled for any existing member accounts
    /// in your
    /// organization.
    ///
    /// This operation merges the new data lake organization configuration with the
    /// existing configuration for Security Lake in your organization. If you want
    /// to create a new data lake organization configuration, you must delete the
    /// existing one using
    /// [DeleteDataLakeOrganizationConfiguration](https://docs.aws.amazon.com/security-lake/latest/APIReference/API_DeleteDataLakeOrganizationConfiguration.html).
    pub fn createDataLakeOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_data_lake_organization_configuration.CreateDataLakeOrganizationConfigurationInput, options: create_data_lake_organization_configuration.Options) !create_data_lake_organization_configuration.CreateDataLakeOrganizationConfigurationOutput {
        return create_data_lake_organization_configuration.execute(self, allocator, input, options);
    }

    /// Creates a subscriber for accounts that are already enabled in Amazon
    /// Security Lake. You can
    /// create a subscriber with access to data in the current Amazon Web Services
    /// Region.
    pub fn createSubscriber(self: *Self, allocator: std.mem.Allocator, input: create_subscriber.CreateSubscriberInput, options: create_subscriber.Options) !create_subscriber.CreateSubscriberOutput {
        return create_subscriber.execute(self, allocator, input, options);
    }

    /// Notifies the subscriber when new data is written to the data lake for the
    /// sources that
    /// the subscriber consumes in Security Lake. You can create only one subscriber
    /// notification per
    /// subscriber.
    pub fn createSubscriberNotification(self: *Self, allocator: std.mem.Allocator, input: create_subscriber_notification.CreateSubscriberNotificationInput, options: create_subscriber_notification.Options) !create_subscriber_notification.CreateSubscriberNotificationOutput {
        return create_subscriber_notification.execute(self, allocator, input, options);
    }

    /// Removes a natively supported Amazon Web Services service as an Amazon
    /// Security Lake source. You
    /// can remove a source for one or more Regions. When you remove the source,
    /// Security Lake stops
    /// collecting data from that source in the specified Regions and accounts, and
    /// subscribers can
    /// no longer consume new data from the source. However, subscribers can still
    /// consume data
    /// that Security Lake collected from the source before removal.
    ///
    /// You can choose any source type in any Amazon Web Services Region for either
    /// accounts that
    /// are part of a trusted organization or standalone accounts.
    pub fn deleteAwsLogSource(self: *Self, allocator: std.mem.Allocator, input: delete_aws_log_source.DeleteAwsLogSourceInput, options: delete_aws_log_source.Options) !delete_aws_log_source.DeleteAwsLogSourceOutput {
        return delete_aws_log_source.execute(self, allocator, input, options);
    }

    /// Removes a custom log source from Amazon Security Lake, to stop sending data
    /// from the custom
    /// source to Security Lake.
    pub fn deleteCustomLogSource(self: *Self, allocator: std.mem.Allocator, input: delete_custom_log_source.DeleteCustomLogSourceInput, options: delete_custom_log_source.Options) !delete_custom_log_source.DeleteCustomLogSourceOutput {
        return delete_custom_log_source.execute(self, allocator, input, options);
    }

    /// When you disable Amazon Security Lake from your account, Security Lake is
    /// disabled in all Amazon Web Services Regions and it stops collecting data
    /// from your sources. Also, this API
    /// automatically takes steps to remove the account from Security Lake. However,
    /// Security Lake retains
    /// all of your existing settings and the resources that it created in your
    /// Amazon Web Services
    /// account in the current Amazon Web Services Region.
    ///
    /// The `DeleteDataLake` operation does not delete the data that is stored in
    /// your Amazon S3 bucket, which is owned by your Amazon Web Services account.
    /// For more
    /// information, see the [Amazon Security Lake User
    /// Guide](https://docs.aws.amazon.com/security-lake/latest/userguide/disable-security-lake.html).
    pub fn deleteDataLake(self: *Self, allocator: std.mem.Allocator, input: delete_data_lake.DeleteDataLakeInput, options: delete_data_lake.Options) !delete_data_lake.DeleteDataLakeOutput {
        return delete_data_lake.execute(self, allocator, input, options);
    }

    /// Deletes the specified notification subscription in Amazon Security Lake for
    /// the organization
    /// you specify.
    pub fn deleteDataLakeExceptionSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_data_lake_exception_subscription.DeleteDataLakeExceptionSubscriptionInput, options: delete_data_lake_exception_subscription.Options) !delete_data_lake_exception_subscription.DeleteDataLakeExceptionSubscriptionOutput {
        return delete_data_lake_exception_subscription.execute(self, allocator, input, options);
    }

    /// Turns off automatic enablement of Amazon Security Lake for member accounts
    /// that are added to an organization in Organizations. Only the delegated
    /// Security Lake administrator for an organization can perform this operation.
    /// If the delegated Security Lake administrator performs this operation, new
    /// member
    /// accounts won't automatically contribute data to the data lake.
    pub fn deleteDataLakeOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_data_lake_organization_configuration.DeleteDataLakeOrganizationConfigurationInput, options: delete_data_lake_organization_configuration.Options) !delete_data_lake_organization_configuration.DeleteDataLakeOrganizationConfigurationOutput {
        return delete_data_lake_organization_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the subscription permission and all notification settings for
    /// accounts that are
    /// already enabled in Amazon Security Lake. When you run `DeleteSubscriber`,
    /// the
    /// subscriber will no longer consume data from Security Lake and the subscriber
    /// is removed. This
    /// operation deletes the subscriber and removes access to data in the current
    /// Amazon Web Services Region.
    pub fn deleteSubscriber(self: *Self, allocator: std.mem.Allocator, input: delete_subscriber.DeleteSubscriberInput, options: delete_subscriber.Options) !delete_subscriber.DeleteSubscriberOutput {
        return delete_subscriber.execute(self, allocator, input, options);
    }

    /// Deletes the specified subscription notification in Amazon Security Lake for
    /// the organization
    /// you specify.
    pub fn deleteSubscriberNotification(self: *Self, allocator: std.mem.Allocator, input: delete_subscriber_notification.DeleteSubscriberNotificationInput, options: delete_subscriber_notification.Options) !delete_subscriber_notification.DeleteSubscriberNotificationOutput {
        return delete_subscriber_notification.execute(self, allocator, input, options);
    }

    /// Deletes the Amazon Security Lake delegated administrator account for the
    /// organization. This API
    /// can only be called by the organization management account. The organization
    /// management
    /// account cannot be the delegated administrator account.
    pub fn deregisterDataLakeDelegatedAdministrator(self: *Self, allocator: std.mem.Allocator, input: deregister_data_lake_delegated_administrator.DeregisterDataLakeDelegatedAdministratorInput, options: deregister_data_lake_delegated_administrator.Options) !deregister_data_lake_delegated_administrator.DeregisterDataLakeDelegatedAdministratorOutput {
        return deregister_data_lake_delegated_administrator.execute(self, allocator, input, options);
    }

    /// Retrieves the protocol and endpoint that were provided when subscribing to
    /// Amazon SNS topics for exception notifications.
    pub fn getDataLakeExceptionSubscription(self: *Self, allocator: std.mem.Allocator, input: get_data_lake_exception_subscription.GetDataLakeExceptionSubscriptionInput, options: get_data_lake_exception_subscription.Options) !get_data_lake_exception_subscription.GetDataLakeExceptionSubscriptionOutput {
        return get_data_lake_exception_subscription.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration that will be automatically set up for accounts
    /// added to the
    /// organization after the organization has onboarded to Amazon Security Lake.
    /// This API does not take
    /// input parameters.
    pub fn getDataLakeOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_data_lake_organization_configuration.GetDataLakeOrganizationConfigurationInput, options: get_data_lake_organization_configuration.Options) !get_data_lake_organization_configuration.GetDataLakeOrganizationConfigurationOutput {
        return get_data_lake_organization_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves a snapshot of the current Region, including whether Amazon
    /// Security Lake is enabled
    /// for those accounts and which sources Security Lake is collecting data from.
    pub fn getDataLakeSources(self: *Self, allocator: std.mem.Allocator, input: get_data_lake_sources.GetDataLakeSourcesInput, options: get_data_lake_sources.Options) !get_data_lake_sources.GetDataLakeSourcesOutput {
        return get_data_lake_sources.execute(self, allocator, input, options);
    }

    /// Retrieves the subscription information for the specified subscription ID.
    /// You can get
    /// information about a specific subscriber.
    pub fn getSubscriber(self: *Self, allocator: std.mem.Allocator, input: get_subscriber.GetSubscriberInput, options: get_subscriber.Options) !get_subscriber.GetSubscriberOutput {
        return get_subscriber.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Security Lake exceptions that you can use to find the
    /// source of problems and
    /// fix them.
    pub fn listDataLakeExceptions(self: *Self, allocator: std.mem.Allocator, input: list_data_lake_exceptions.ListDataLakeExceptionsInput, options: list_data_lake_exceptions.Options) !list_data_lake_exceptions.ListDataLakeExceptionsOutput {
        return list_data_lake_exceptions.execute(self, allocator, input, options);
    }

    /// Retrieves the Amazon Security Lake configuration object for the specified
    /// Amazon Web Services Regions. You can use this operation to determine whether
    /// Security Lake is enabled for a Region.
    pub fn listDataLakes(self: *Self, allocator: std.mem.Allocator, input: list_data_lakes.ListDataLakesInput, options: list_data_lakes.Options) !list_data_lakes.ListDataLakesOutput {
        return list_data_lakes.execute(self, allocator, input, options);
    }

    /// Retrieves the log sources.
    pub fn listLogSources(self: *Self, allocator: std.mem.Allocator, input: list_log_sources.ListLogSourcesInput, options: list_log_sources.Options) !list_log_sources.ListLogSourcesOutput {
        return list_log_sources.execute(self, allocator, input, options);
    }

    /// Lists all subscribers for the specific Amazon Security Lake account ID. You
    /// can retrieve a list
    /// of subscriptions associated with a specific organization or Amazon Web
    /// Services account.
    pub fn listSubscribers(self: *Self, allocator: std.mem.Allocator, input: list_subscribers.ListSubscribersInput, options: list_subscribers.Options) !list_subscribers.ListSubscribersOutput {
        return list_subscribers.execute(self, allocator, input, options);
    }

    /// Retrieves the tags (keys and values) that are associated with an Amazon
    /// Security Lake resource: a subscriber, or the data lake configuration for
    /// your Amazon Web Services account in a particular Amazon Web Services Region.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Designates the Amazon Security Lake delegated administrator account for the
    /// organization. This
    /// API can only be called by the organization management account. The
    /// organization management
    /// account cannot be the delegated administrator account.
    pub fn registerDataLakeDelegatedAdministrator(self: *Self, allocator: std.mem.Allocator, input: register_data_lake_delegated_administrator.RegisterDataLakeDelegatedAdministratorInput, options: register_data_lake_delegated_administrator.Options) !register_data_lake_delegated_administrator.RegisterDataLakeDelegatedAdministratorOutput {
        return register_data_lake_delegated_administrator.execute(self, allocator, input, options);
    }

    /// Adds or updates one or more tags that are associated with an Amazon Security
    /// Lake resource: a subscriber, or the data lake configuration for your
    /// Amazon Web Services account in a particular Amazon Web Services Region. A
    /// *tag* is a label that you can define and associate with
    /// Amazon Web Services resources. Each tag consists of a required *tag key* and
    /// an associated *tag value*. A
    /// *tag key* is a general label that acts as a category for a more specific tag
    /// value. A *tag value* acts as a
    /// descriptor for a tag key. Tags can help you identify, categorize, and manage
    /// resources in different ways, such as by owner, environment, or other
    /// criteria. For more information, see
    /// [Tagging Amazon Security Lake
    /// resources](https://docs.aws.amazon.com/security-lake/latest/userguide/tagging-resources.html) in the
    /// *Amazon Security Lake User Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags (keys and values) from an Amazon Security Lake
    /// resource: a subscriber, or the data lake configuration for your
    /// Amazon Web Services account in a particular Amazon Web Services Region.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// You can use `UpdateDataLake` to specify where to store your security data,
    /// how it should
    /// be encrypted at rest and for how long. You can add a [Rollup
    /// Region](https://docs.aws.amazon.com/security-lake/latest/userguide/manage-regions.html#add-rollup-region) to consolidate data from multiple Amazon Web Services Regions, replace
    /// default encryption (SSE-S3) with [Customer Manged
    /// Key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk),
    /// or specify transition and expiration actions through storage [Lifecycle
    /// management](https://docs.aws.amazon.com/security-lake/latest/userguide/lifecycle-management.html). The `UpdateDataLake` API works as an "upsert" operation that performs an insert if the specified item or record does not exist, or an update if it
    /// already exists. Security Lake securely stores your data at rest using Amazon
    /// Web Services encryption solutions. For more details, see [Data protection in
    /// Amazon Security
    /// Lake](https://docs.aws.amazon.com/security-lake/latest/userguide/data-protection.html).
    ///
    /// For example, omitting the key `encryptionConfiguration` from a Region that
    /// is
    /// included in an update call that currently uses KMS will leave that Region's
    /// KMS key in
    /// place, but specifying `encryptionConfiguration: {kmsKeyId:
    /// 'S3_MANAGED_KEY'}`
    /// for that same Region will reset the key to `S3-managed`.
    ///
    /// For more details about lifecycle management and how to update retention
    /// settings for one or more Regions after enabling Security Lake, see the
    /// [Amazon Security Lake User
    /// Guide](https://docs.aws.amazon.com/security-lake/latest/userguide/lifecycle-management.html).
    pub fn updateDataLake(self: *Self, allocator: std.mem.Allocator, input: update_data_lake.UpdateDataLakeInput, options: update_data_lake.Options) !update_data_lake.UpdateDataLakeOutput {
        return update_data_lake.execute(self, allocator, input, options);
    }

    /// Updates the specified notification subscription in Amazon Security Lake for
    /// the organization
    /// you specify.
    pub fn updateDataLakeExceptionSubscription(self: *Self, allocator: std.mem.Allocator, input: update_data_lake_exception_subscription.UpdateDataLakeExceptionSubscriptionInput, options: update_data_lake_exception_subscription.Options) !update_data_lake_exception_subscription.UpdateDataLakeExceptionSubscriptionOutput {
        return update_data_lake_exception_subscription.execute(self, allocator, input, options);
    }

    /// Updates an existing subscription for the given Amazon Security Lake account
    /// ID. You can update
    /// a subscriber by changing the sources that the subscriber consumes data from.
    pub fn updateSubscriber(self: *Self, allocator: std.mem.Allocator, input: update_subscriber.UpdateSubscriberInput, options: update_subscriber.Options) !update_subscriber.UpdateSubscriberOutput {
        return update_subscriber.execute(self, allocator, input, options);
    }

    /// Updates an existing notification method for the subscription (SQS or HTTPs
    /// endpoint) or
    /// switches the notification subscription endpoint for a subscriber.
    pub fn updateSubscriberNotification(self: *Self, allocator: std.mem.Allocator, input: update_subscriber_notification.UpdateSubscriberNotificationInput, options: update_subscriber_notification.Options) !update_subscriber_notification.UpdateSubscriberNotificationOutput {
        return update_subscriber_notification.execute(self, allocator, input, options);
    }

    pub fn getDataLakeSourcesPaginator(self: *Self, params: get_data_lake_sources.GetDataLakeSourcesInput) paginator.GetDataLakeSourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataLakeExceptionsPaginator(self: *Self, params: list_data_lake_exceptions.ListDataLakeExceptionsInput) paginator.ListDataLakeExceptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLogSourcesPaginator(self: *Self, params: list_log_sources.ListLogSourcesInput) paginator.ListLogSourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSubscribersPaginator(self: *Self, params: list_subscribers.ListSubscribersInput) paginator.ListSubscribersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
