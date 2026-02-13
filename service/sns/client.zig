const aws = @import("aws");
const std = @import("std");


const add_permission = @import("add_permission.zig");
const check_if_phone_number_is_opted_out = @import("check_if_phone_number_is_opted_out.zig");
const confirm_subscription = @import("confirm_subscription.zig");
const create_platform_application = @import("create_platform_application.zig");
const create_platform_endpoint = @import("create_platform_endpoint.zig");
const create_sms_sandbox_phone_number = @import("create_sms_sandbox_phone_number.zig");
const create_topic = @import("create_topic.zig");
const delete_endpoint = @import("delete_endpoint.zig");
const delete_platform_application = @import("delete_platform_application.zig");
const delete_sms_sandbox_phone_number = @import("delete_sms_sandbox_phone_number.zig");
const delete_topic = @import("delete_topic.zig");
const get_data_protection_policy = @import("get_data_protection_policy.zig");
const get_endpoint_attributes = @import("get_endpoint_attributes.zig");
const get_platform_application_attributes = @import("get_platform_application_attributes.zig");
const get_sms_attributes = @import("get_sms_attributes.zig");
const get_sms_sandbox_account_status = @import("get_sms_sandbox_account_status.zig");
const get_subscription_attributes = @import("get_subscription_attributes.zig");
const get_topic_attributes = @import("get_topic_attributes.zig");
const list_endpoints_by_platform_application = @import("list_endpoints_by_platform_application.zig");
const list_origination_numbers = @import("list_origination_numbers.zig");
const list_phone_numbers_opted_out = @import("list_phone_numbers_opted_out.zig");
const list_platform_applications = @import("list_platform_applications.zig");
const list_sms_sandbox_phone_numbers = @import("list_sms_sandbox_phone_numbers.zig");
const list_subscriptions = @import("list_subscriptions.zig");
const list_subscriptions_by_topic = @import("list_subscriptions_by_topic.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_topics = @import("list_topics.zig");
const opt_in_phone_number = @import("opt_in_phone_number.zig");
const publish_ = @import("publish.zig");
const publish_batch = @import("publish_batch.zig");
const put_data_protection_policy = @import("put_data_protection_policy.zig");
const remove_permission = @import("remove_permission.zig");
const set_endpoint_attributes = @import("set_endpoint_attributes.zig");
const set_platform_application_attributes = @import("set_platform_application_attributes.zig");
const set_sms_attributes = @import("set_sms_attributes.zig");
const set_subscription_attributes = @import("set_subscription_attributes.zig");
const set_topic_attributes = @import("set_topic_attributes.zig");
const subscribe_ = @import("subscribe.zig");
const tag_resource = @import("tag_resource.zig");
const unsubscribe_ = @import("unsubscribe.zig");
const untag_resource = @import("untag_resource.zig");
const verify_sms_sandbox_phone_number = @import("verify_sms_sandbox_phone_number.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Adds a statement to a topic's access control policy, granting access for the
    /// specified
    /// Amazon Web Services accounts to the specified actions.
    ///
    /// **Note:**
    ///
    /// To remove the ability to change topic permissions, you must deny permissions
    /// to
    /// the `AddPermission`, `RemovePermission`, and
    /// `SetTopicAttributes` actions in your IAM policy.
    pub fn addPermission(self: *Self, input: add_permission.AddPermissionInput, options: add_permission.Options) !add_permission.AddPermissionOutput {
        return add_permission.execute(self, input, options);
    }

    /// Accepts a phone number and indicates whether the phone holder has opted out
    /// of
    /// receiving SMS messages from your Amazon Web Services account. You cannot
    /// send SMS messages to a number
    /// that is opted out.
    ///
    /// To resume sending messages, you can opt in the number by using the
    /// `OptInPhoneNumber` action.
    pub fn checkIfPhoneNumberIsOptedOut(self: *Self, input: check_if_phone_number_is_opted_out.CheckIfPhoneNumberIsOptedOutInput, options: check_if_phone_number_is_opted_out.Options) !check_if_phone_number_is_opted_out.CheckIfPhoneNumberIsOptedOutOutput {
        return check_if_phone_number_is_opted_out.execute(self, input, options);
    }

    /// Verifies an endpoint owner's intent to receive messages by validating the
    /// token sent
    /// to the endpoint by an earlier `Subscribe` action. If the token is valid, the
    /// action creates a new subscription and returns its Amazon Resource Name
    /// (ARN). This call
    /// requires an AWS signature only when the `AuthenticateOnUnsubscribe` flag is
    /// set to "true".
    pub fn confirmSubscription(self: *Self, input: confirm_subscription.ConfirmSubscriptionInput, options: confirm_subscription.Options) !confirm_subscription.ConfirmSubscriptionOutput {
        return confirm_subscription.execute(self, input, options);
    }

    /// Creates a platform application object for one of the supported push
    /// notification
    /// services, such as APNS and GCM (Firebase Cloud Messaging), to which devices
    /// and mobile
    /// apps may register. You must specify `PlatformPrincipal` and
    /// `PlatformCredential` attributes when using the
    /// `CreatePlatformApplication` action.
    ///
    /// `PlatformPrincipal` and `PlatformCredential` are received from
    /// the notification service.
    ///
    /// * For ADM, `PlatformPrincipal` is `client id` and
    /// `PlatformCredential` is `client secret`.
    ///
    /// * For APNS and `APNS_SANDBOX` using certificate credentials,
    /// `PlatformPrincipal` is `SSL certificate` and
    /// `PlatformCredential` is `private key`.
    ///
    /// * For APNS and `APNS_SANDBOX` using token credentials,
    /// `PlatformPrincipal` is `signing key ID` and
    /// `PlatformCredential` is `signing key`.
    ///
    /// * For Baidu, `PlatformPrincipal` is `API key` and
    /// `PlatformCredential` is `secret key`.
    ///
    /// * For GCM (Firebase Cloud Messaging) using key credentials, there is no
    /// `PlatformPrincipal`. The `PlatformCredential` is
    /// `API key`.
    ///
    /// * For GCM (Firebase Cloud Messaging) using token credentials, there is no
    /// `PlatformPrincipal`. The `PlatformCredential` is a
    /// JSON formatted private key file. When using the Amazon Web Services CLI or
    /// Amazon Web Services SDKs, the
    /// file must be in string format and special characters must be ignored. To
    /// format
    /// the file correctly, Amazon SNS recommends using the following command:
    /// `SERVICE_JSON=$(jq @json < service.json)`.
    ///
    /// * For MPNS, `PlatformPrincipal` is `TLS certificate` and
    /// `PlatformCredential` is `private key`.
    ///
    /// * For WNS, `PlatformPrincipal` is `Package Security
    /// Identifier` and `PlatformCredential` is `secret
    /// key`.
    ///
    /// You can use the returned `PlatformApplicationArn` as an attribute for the
    /// `CreatePlatformEndpoint` action.
    pub fn createPlatformApplication(self: *Self, input: create_platform_application.CreatePlatformApplicationInput, options: create_platform_application.Options) !create_platform_application.CreatePlatformApplicationOutput {
        return create_platform_application.execute(self, input, options);
    }

    /// Creates an endpoint for a device and mobile app on one of the supported push
    /// notification services, such as GCM (Firebase Cloud Messaging) and APNS.
    /// `CreatePlatformEndpoint` requires the `PlatformApplicationArn`
    /// that is returned from `CreatePlatformApplication`. You can use the returned
    /// `EndpointArn` to send a message to a mobile app or by the
    /// `Subscribe` action for subscription to a topic. The
    /// `CreatePlatformEndpoint` action is idempotent, so if the requester
    /// already owns an endpoint with the same device token and attributes, that
    /// endpoint's ARN
    /// is returned without creating a new endpoint. For more information, see
    /// [Using Amazon SNS Mobile Push
    /// Notifications](https://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
    ///
    /// When using `CreatePlatformEndpoint` with Baidu, two attributes must be
    /// provided: ChannelId and UserId. The token field must also contain the
    /// ChannelId. For
    /// more information, see [Creating an Amazon SNS Endpoint for
    /// Baidu](https://docs.aws.amazon.com/sns/latest/dg/SNSMobilePushBaiduEndpoint.html).
    pub fn createPlatformEndpoint(self: *Self, input: create_platform_endpoint.CreatePlatformEndpointInput, options: create_platform_endpoint.Options) !create_platform_endpoint.CreatePlatformEndpointOutput {
        return create_platform_endpoint.execute(self, input, options);
    }

    /// Adds a destination phone number to an Amazon Web Services account in the SMS
    /// sandbox and sends a
    /// one-time password (OTP) to that phone number.
    ///
    /// When you start using Amazon SNS to send SMS messages, your Amazon Web
    /// Services account is in the
    /// *SMS sandbox*. The SMS sandbox provides a safe environment for
    /// you to try Amazon SNS features without risking your reputation as an SMS
    /// sender. While your
    /// Amazon Web Services account is in the SMS sandbox, you can use all of the
    /// features of Amazon SNS. However, you can send
    /// SMS messages only to verified destination phone numbers. For more
    /// information, including how to
    /// move out of the sandbox to send messages without restrictions,
    /// see [SMS
    /// sandbox](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html) in
    /// the *Amazon SNS Developer Guide*.
    pub fn createSmsSandboxPhoneNumber(self: *Self, input: create_sms_sandbox_phone_number.CreateSMSSandboxPhoneNumberInput, options: create_sms_sandbox_phone_number.Options) !create_sms_sandbox_phone_number.CreateSMSSandboxPhoneNumberOutput {
        return create_sms_sandbox_phone_number.execute(self, input, options);
    }

    /// Creates a topic to which notifications can be published. Users can create at
    /// most
    /// 100,000 standard topics (at most 1,000 FIFO topics). For more information,
    /// see [Creating an Amazon SNS
    /// topic](https://docs.aws.amazon.com/sns/latest/dg/sns-create-topic.html) in
    /// the *Amazon SNS Developer Guide*. This action is
    /// idempotent, so if the requester already owns a topic with the specified
    /// name, that
    /// topic's ARN is returned without creating a new topic.
    pub fn createTopic(self: *Self, input: create_topic.CreateTopicInput, options: create_topic.Options) !create_topic.CreateTopicOutput {
        return create_topic.execute(self, input, options);
    }

    /// Deletes the endpoint for a device and mobile app from Amazon SNS. This
    /// action is
    /// idempotent. For more information, see [Using Amazon SNS Mobile Push
    /// Notifications](https://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
    ///
    /// When you delete an endpoint that is also subscribed to a topic, then you
    /// must also
    /// unsubscribe the endpoint from the topic.
    pub fn deleteEndpoint(self: *Self, input: delete_endpoint.DeleteEndpointInput, options: delete_endpoint.Options) !delete_endpoint.DeleteEndpointOutput {
        return delete_endpoint.execute(self, input, options);
    }

    /// Deletes a platform application object for one of the supported push
    /// notification
    /// services, such as APNS and GCM (Firebase Cloud Messaging). For more
    /// information, see
    /// [Using Amazon SNS
    /// Mobile Push
    /// Notifications](https://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
    pub fn deletePlatformApplication(self: *Self, input: delete_platform_application.DeletePlatformApplicationInput, options: delete_platform_application.Options) !delete_platform_application.DeletePlatformApplicationOutput {
        return delete_platform_application.execute(self, input, options);
    }

    /// Deletes an Amazon Web Services account's verified or pending phone number
    /// from the SMS
    /// sandbox.
    ///
    /// When you start using Amazon SNS to send SMS messages, your Amazon Web
    /// Services account is in the
    /// *SMS sandbox*. The SMS sandbox provides a safe environment for
    /// you to try Amazon SNS features without risking your reputation as an SMS
    /// sender. While your
    /// Amazon Web Services account is in the SMS sandbox, you can use all of the
    /// features of Amazon SNS. However, you can send
    /// SMS messages only to verified destination phone numbers. For more
    /// information, including how to
    /// move out of the sandbox to send messages without restrictions,
    /// see [SMS
    /// sandbox](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html) in
    /// the *Amazon SNS Developer Guide*.
    pub fn deleteSmsSandboxPhoneNumber(self: *Self, input: delete_sms_sandbox_phone_number.DeleteSMSSandboxPhoneNumberInput, options: delete_sms_sandbox_phone_number.Options) !delete_sms_sandbox_phone_number.DeleteSMSSandboxPhoneNumberOutput {
        return delete_sms_sandbox_phone_number.execute(self, input, options);
    }

    /// Deletes a topic and all its subscriptions. Deleting a topic might prevent
    /// some
    /// messages previously sent to the topic from being delivered to subscribers.
    /// This action
    /// is idempotent, so deleting a topic that does not exist does not result in an
    /// error.
    pub fn deleteTopic(self: *Self, input: delete_topic.DeleteTopicInput, options: delete_topic.Options) !delete_topic.DeleteTopicOutput {
        return delete_topic.execute(self, input, options);
    }

    /// Retrieves the specified inline `DataProtectionPolicy` document that is
    /// stored in the specified Amazon SNS topic.
    pub fn getDataProtectionPolicy(self: *Self, input: get_data_protection_policy.GetDataProtectionPolicyInput, options: get_data_protection_policy.Options) !get_data_protection_policy.GetDataProtectionPolicyOutput {
        return get_data_protection_policy.execute(self, input, options);
    }

    /// Retrieves the endpoint attributes for a device on one of the supported push
    /// notification services, such as GCM (Firebase Cloud Messaging) and APNS. For
    /// more
    /// information, see [Using Amazon SNS Mobile Push
    /// Notifications](https://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
    pub fn getEndpointAttributes(self: *Self, input: get_endpoint_attributes.GetEndpointAttributesInput, options: get_endpoint_attributes.Options) !get_endpoint_attributes.GetEndpointAttributesOutput {
        return get_endpoint_attributes.execute(self, input, options);
    }

    /// Retrieves the attributes of the platform application object for the
    /// supported push
    /// notification services, such as APNS and GCM (Firebase Cloud Messaging). For
    /// more
    /// information, see [Using Amazon SNS Mobile Push
    /// Notifications](https://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
    pub fn getPlatformApplicationAttributes(self: *Self, input: get_platform_application_attributes.GetPlatformApplicationAttributesInput, options: get_platform_application_attributes.Options) !get_platform_application_attributes.GetPlatformApplicationAttributesOutput {
        return get_platform_application_attributes.execute(self, input, options);
    }

    /// Returns the settings for sending SMS messages from your Amazon Web Services
    /// account.
    ///
    /// These settings are set with the `SetSMSAttributes` action.
    pub fn getSmsAttributes(self: *Self, input: get_sms_attributes.GetSMSAttributesInput, options: get_sms_attributes.Options) !get_sms_attributes.GetSMSAttributesOutput {
        return get_sms_attributes.execute(self, input, options);
    }

    /// Retrieves the SMS sandbox status for the calling Amazon Web Services account
    /// in the target
    /// Amazon Web Services Region.
    ///
    /// When you start using Amazon SNS to send SMS messages, your Amazon Web
    /// Services account is in the
    /// *SMS sandbox*. The SMS sandbox provides a safe environment for
    /// you to try Amazon SNS features without risking your reputation as an SMS
    /// sender. While your
    /// Amazon Web Services account is in the SMS sandbox, you can use all of the
    /// features of Amazon SNS. However, you can send
    /// SMS messages only to verified destination phone numbers. For more
    /// information, including how to
    /// move out of the sandbox to send messages without restrictions,
    /// see [SMS
    /// sandbox](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html) in
    /// the *Amazon SNS Developer Guide*.
    pub fn getSmsSandboxAccountStatus(self: *Self, input: get_sms_sandbox_account_status.GetSMSSandboxAccountStatusInput, options: get_sms_sandbox_account_status.Options) !get_sms_sandbox_account_status.GetSMSSandboxAccountStatusOutput {
        return get_sms_sandbox_account_status.execute(self, input, options);
    }

    /// Returns all of the properties of a subscription.
    pub fn getSubscriptionAttributes(self: *Self, input: get_subscription_attributes.GetSubscriptionAttributesInput, options: get_subscription_attributes.Options) !get_subscription_attributes.GetSubscriptionAttributesOutput {
        return get_subscription_attributes.execute(self, input, options);
    }

    /// Returns all of the properties of a topic. Topic properties returned might
    /// differ based
    /// on the authorization of the user.
    pub fn getTopicAttributes(self: *Self, input: get_topic_attributes.GetTopicAttributesInput, options: get_topic_attributes.Options) !get_topic_attributes.GetTopicAttributesOutput {
        return get_topic_attributes.execute(self, input, options);
    }

    /// Lists the endpoints and endpoint attributes for devices in a supported push
    /// notification service, such as GCM (Firebase Cloud Messaging) and APNS. The
    /// results for
    /// `ListEndpointsByPlatformApplication` are paginated and return a limited
    /// list of endpoints, up to 100. If additional records are available after the
    /// first page
    /// results, then a NextToken string will be returned. To receive the next page,
    /// you call
    /// `ListEndpointsByPlatformApplication` again using the NextToken string
    /// received from the previous call. When there are no more records to return,
    /// NextToken
    /// will be null. For more information, see [Using Amazon SNS Mobile Push
    /// Notifications](https://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
    ///
    /// This action is throttled at 30 transactions per second (TPS).
    pub fn listEndpointsByPlatformApplication(self: *Self, input: list_endpoints_by_platform_application.ListEndpointsByPlatformApplicationInput, options: list_endpoints_by_platform_application.Options) !list_endpoints_by_platform_application.ListEndpointsByPlatformApplicationOutput {
        return list_endpoints_by_platform_application.execute(self, input, options);
    }

    /// Lists the calling Amazon Web Services account's dedicated origination
    /// numbers and their metadata.
    /// For more information about origination numbers, see [Origination
    /// numbers](https://docs.aws.amazon.com/sns/latest/dg/channels-sms-originating-identities-origination-numbers.html) in the *Amazon SNS Developer
    /// Guide*.
    pub fn listOriginationNumbers(self: *Self, input: list_origination_numbers.ListOriginationNumbersInput, options: list_origination_numbers.Options) !list_origination_numbers.ListOriginationNumbersOutput {
        return list_origination_numbers.execute(self, input, options);
    }

    /// Returns a list of phone numbers that are opted out, meaning you cannot send
    /// SMS
    /// messages to them.
    ///
    /// The results for `ListPhoneNumbersOptedOut` are paginated, and each page
    /// returns up to 100 phone numbers. If additional phone numbers are available
    /// after the
    /// first page of results, then a `NextToken` string will be returned. To
    /// receive
    /// the next page, you call `ListPhoneNumbersOptedOut` again using the
    /// `NextToken` string received from the previous call. When there are no
    /// more records to return, `NextToken` will be null.
    pub fn listPhoneNumbersOptedOut(self: *Self, input: list_phone_numbers_opted_out.ListPhoneNumbersOptedOutInput, options: list_phone_numbers_opted_out.Options) !list_phone_numbers_opted_out.ListPhoneNumbersOptedOutOutput {
        return list_phone_numbers_opted_out.execute(self, input, options);
    }

    /// Lists the platform application objects for the supported push notification
    /// services,
    /// such as APNS and GCM (Firebase Cloud Messaging). The results for
    /// `ListPlatformApplications` are paginated and return a limited list of
    /// applications, up to 100. If additional records are available after the first
    /// page
    /// results, then a NextToken string will be returned. To receive the next page,
    /// you call
    /// `ListPlatformApplications` using the NextToken string received from the
    /// previous call. When there are no more records to return, `NextToken` will be
    /// null. For more information, see [Using Amazon SNS Mobile Push
    /// Notifications](https://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
    ///
    /// This action is throttled at 15 transactions per second (TPS).
    pub fn listPlatformApplications(self: *Self, input: list_platform_applications.ListPlatformApplicationsInput, options: list_platform_applications.Options) !list_platform_applications.ListPlatformApplicationsOutput {
        return list_platform_applications.execute(self, input, options);
    }

    /// Lists the calling Amazon Web Services account's current verified and pending
    /// destination phone
    /// numbers in the SMS sandbox.
    ///
    /// When you start using Amazon SNS to send SMS messages, your Amazon Web
    /// Services account is in the
    /// *SMS sandbox*. The SMS sandbox provides a safe environment for
    /// you to try Amazon SNS features without risking your reputation as an SMS
    /// sender. While your
    /// Amazon Web Services account is in the SMS sandbox, you can use all of the
    /// features of Amazon SNS. However, you can send
    /// SMS messages only to verified destination phone numbers. For more
    /// information, including how to
    /// move out of the sandbox to send messages without restrictions,
    /// see [SMS
    /// sandbox](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html) in
    /// the *Amazon SNS Developer Guide*.
    pub fn listSmsSandboxPhoneNumbers(self: *Self, input: list_sms_sandbox_phone_numbers.ListSMSSandboxPhoneNumbersInput, options: list_sms_sandbox_phone_numbers.Options) !list_sms_sandbox_phone_numbers.ListSMSSandboxPhoneNumbersOutput {
        return list_sms_sandbox_phone_numbers.execute(self, input, options);
    }

    /// Returns a list of the requester's subscriptions. Each call returns a limited
    /// list of
    /// subscriptions, up to 100. If there are more subscriptions, a `NextToken` is
    /// also returned. Use the `NextToken` parameter in a new
    /// `ListSubscriptions` call to get further results.
    ///
    /// This action is throttled at 30 transactions per second (TPS).
    pub fn listSubscriptions(self: *Self, input: list_subscriptions.ListSubscriptionsInput, options: list_subscriptions.Options) !list_subscriptions.ListSubscriptionsOutput {
        return list_subscriptions.execute(self, input, options);
    }

    /// Returns a list of the subscriptions to a specific topic. Each call returns a
    /// limited
    /// list of subscriptions, up to 100. If there are more subscriptions, a
    /// `NextToken` is also returned. Use the `NextToken` parameter in
    /// a new `ListSubscriptionsByTopic` call to get further results.
    ///
    /// This action is throttled at 30 transactions per second (TPS).
    pub fn listSubscriptionsByTopic(self: *Self, input: list_subscriptions_by_topic.ListSubscriptionsByTopicInput, options: list_subscriptions_by_topic.Options) !list_subscriptions_by_topic.ListSubscriptionsByTopicOutput {
        return list_subscriptions_by_topic.execute(self, input, options);
    }

    /// List all tags added to the specified Amazon SNS topic. For an overview, see
    /// [Amazon SNS Tags](https://docs.aws.amazon.com/sns/latest/dg/sns-tags.html)
    /// in the
    /// *Amazon Simple Notification Service Developer Guide*.
    pub fn listTagsForResource(self: *Self, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, input, options);
    }

    /// Returns a list of the requester's topics. Each call returns a limited list
    /// of topics,
    /// up to 100. If there are more topics, a `NextToken` is also returned. Use the
    /// `NextToken` parameter in a new `ListTopics` call to get
    /// further results.
    ///
    /// This action is throttled at 30 transactions per second (TPS).
    pub fn listTopics(self: *Self, input: list_topics.ListTopicsInput, options: list_topics.Options) !list_topics.ListTopicsOutput {
        return list_topics.execute(self, input, options);
    }

    /// Use this request to opt in a phone number that is opted out, which enables
    /// you to
    /// resume sending SMS messages to the number.
    ///
    /// You can opt in a phone number only once every 30 days.
    pub fn optInPhoneNumber(self: *Self, input: opt_in_phone_number.OptInPhoneNumberInput, options: opt_in_phone_number.Options) !opt_in_phone_number.OptInPhoneNumberOutput {
        return opt_in_phone_number.execute(self, input, options);
    }

    /// Sends a message to an Amazon SNS topic, a text message (SMS message)
    /// directly to a phone
    /// number, or a message to a mobile platform endpoint (when you specify the
    /// `TargetArn`).
    ///
    /// If you send a message to a topic, Amazon SNS delivers the message to each
    /// endpoint that is
    /// subscribed to the topic. The format of the message depends on the
    /// notification protocol
    /// for each subscribed endpoint.
    ///
    /// When a `messageId` is returned, the message is saved and Amazon SNS
    /// immediately
    /// delivers it to subscribers.
    ///
    /// To use the `Publish` action for publishing a message to a mobile endpoint,
    /// such as an app on a Kindle device or mobile phone, you must specify the
    /// EndpointArn for
    /// the TargetArn parameter. The EndpointArn is returned when making a call with
    /// the
    /// `CreatePlatformEndpoint` action.
    ///
    /// For more information about formatting messages, see [Send Custom
    /// Platform-Specific Payloads in Messages to Mobile
    /// Devices](https://docs.aws.amazon.com/sns/latest/dg/mobile-push-send-custommessage.html).
    ///
    /// **Important:**
    ///
    /// You can publish messages only to topics and endpoints in the same
    /// Amazon Web Services Region.
    pub fn publish(self: *Self, input: publish_.PublishInput, options: publish_.Options) !publish_.PublishOutput {
        return publish_.execute(self, input, options);
    }

    /// Publishes up to 10 messages to the specified topic in a single batch. This
    /// is a batch
    /// version of the `Publish` API. If you try to send more than 10 messages in a
    /// single batch request, you will receive a `TooManyEntriesInBatchRequest`
    /// exception.
    ///
    /// For FIFO topics, multiple messages within a single batch are published in
    /// the order
    /// they are sent, and messages are deduplicated within the batch and across
    /// batches for
    /// five minutes.
    ///
    /// The result of publishing each message is reported individually in the
    /// response.
    /// Because the batch request can result in a combination of successful and
    /// unsuccessful
    /// actions, you should check for batch errors even when the call returns an
    /// HTTP status
    /// code of 200.
    ///
    /// The maximum allowed individual message size and the maximum total payload
    /// size (the sum
    /// of the individual lengths of all of the batched messages) are both 256 KB
    /// (262,144
    /// bytes).
    ///
    /// **Important:**
    ///
    /// The `PublishBatch` API can send up to 10 messages at a time. If you
    /// attempt to send more than 10 messages in one request, you will encounter a
    /// `TooManyEntriesInBatchRequest` exception. In such cases, split your
    /// messages into multiple requests, each containing no more than 10 messages.
    ///
    /// Some actions take lists of parameters. These lists are specified using the
    /// `param.n` notation. Values of `n` are integers starting from
    /// **1**. For example, a parameter list with two elements
    /// looks like this:
    ///
    /// `&AttributeName.1=first`
    ///
    /// `&AttributeName.2=second`
    ///
    /// If you send a batch message to a topic, Amazon SNS publishes the batch
    /// message to each
    /// endpoint that is subscribed to the topic. The format of the batch message
    /// depends on the
    /// notification protocol for each subscribed endpoint.
    ///
    /// When a `messageId` is returned, the batch message is saved, and Amazon SNS
    /// immediately delivers the message to subscribers.
    pub fn publishBatch(self: *Self, input: publish_batch.PublishBatchInput, options: publish_batch.Options) !publish_batch.PublishBatchOutput {
        return publish_batch.execute(self, input, options);
    }

    /// Adds or updates an inline policy document that is stored in the specified
    /// Amazon SNS
    /// topic.
    pub fn putDataProtectionPolicy(self: *Self, input: put_data_protection_policy.PutDataProtectionPolicyInput, options: put_data_protection_policy.Options) !put_data_protection_policy.PutDataProtectionPolicyOutput {
        return put_data_protection_policy.execute(self, input, options);
    }

    /// Removes a statement from a topic's access control policy.
    ///
    /// **Note:**
    ///
    /// To remove the ability to change topic permissions, you must deny permissions
    /// to
    /// the `AddPermission`, `RemovePermission`, and
    /// `SetTopicAttributes` actions in your IAM policy.
    pub fn removePermission(self: *Self, input: remove_permission.RemovePermissionInput, options: remove_permission.Options) !remove_permission.RemovePermissionOutput {
        return remove_permission.execute(self, input, options);
    }

    /// Sets the attributes for an endpoint for a device on one of the supported
    /// push
    /// notification services, such as GCM (Firebase Cloud Messaging) and APNS. For
    /// more
    /// information, see [Using Amazon SNS Mobile Push
    /// Notifications](https://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
    pub fn setEndpointAttributes(self: *Self, input: set_endpoint_attributes.SetEndpointAttributesInput, options: set_endpoint_attributes.Options) !set_endpoint_attributes.SetEndpointAttributesOutput {
        return set_endpoint_attributes.execute(self, input, options);
    }

    /// Sets the attributes of the platform application object for the supported
    /// push
    /// notification services, such as APNS and GCM (Firebase Cloud Messaging). For
    /// more
    /// information, see [Using Amazon SNS Mobile Push
    /// Notifications](https://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html). For information on configuring
    /// attributes for message delivery status, see [Using Amazon SNS Application
    /// Attributes for
    /// Message Delivery
    /// Status](https://docs.aws.amazon.com/sns/latest/dg/sns-msg-status.html).
    pub fn setPlatformApplicationAttributes(self: *Self, input: set_platform_application_attributes.SetPlatformApplicationAttributesInput, options: set_platform_application_attributes.Options) !set_platform_application_attributes.SetPlatformApplicationAttributesOutput {
        return set_platform_application_attributes.execute(self, input, options);
    }

    /// Use this request to set the default settings for sending SMS messages and
    /// receiving
    /// daily SMS usage reports.
    ///
    /// You can override some of these settings for a single message when you use
    /// the
    /// `Publish` action with the `MessageAttributes.entry.N`
    /// parameter. For more information, see [Publishing to a mobile
    /// phone](https://docs.aws.amazon.com/sns/latest/dg/sms_publish-to-phone.html)
    /// in the *Amazon SNS Developer Guide*.
    ///
    /// **Note:**
    ///
    /// To use this operation, you must grant the Amazon SNS service principal
    /// (`sns.amazonaws.com`) permission to perform the
    /// `s3:ListBucket` action.
    pub fn setSmsAttributes(self: *Self, input: set_sms_attributes.SetSMSAttributesInput, options: set_sms_attributes.Options) !set_sms_attributes.SetSMSAttributesOutput {
        return set_sms_attributes.execute(self, input, options);
    }

    /// Allows a subscription owner to set an attribute of the subscription to a new
    /// value.
    pub fn setSubscriptionAttributes(self: *Self, input: set_subscription_attributes.SetSubscriptionAttributesInput, options: set_subscription_attributes.Options) !set_subscription_attributes.SetSubscriptionAttributesOutput {
        return set_subscription_attributes.execute(self, input, options);
    }

    /// Allows a topic owner to set an attribute of the topic to a new value.
    ///
    /// **Note:**
    ///
    /// To remove the ability to change topic permissions, you must deny permissions
    /// to
    /// the `AddPermission`, `RemovePermission`, and
    /// `SetTopicAttributes` actions in your IAM policy.
    pub fn setTopicAttributes(self: *Self, input: set_topic_attributes.SetTopicAttributesInput, options: set_topic_attributes.Options) !set_topic_attributes.SetTopicAttributesOutput {
        return set_topic_attributes.execute(self, input, options);
    }

    /// Subscribes an endpoint to an Amazon SNS topic. If the endpoint type is
    /// HTTP/S or email, or
    /// if the endpoint and the topic are not in the same Amazon Web Services
    /// account, the endpoint owner must
    /// run the `ConfirmSubscription` action to confirm the subscription.
    ///
    /// You call the `ConfirmSubscription` action with the token from the
    /// subscription response. Confirmation tokens are valid for two days.
    ///
    /// This action is throttled at 100 transactions per second (TPS).
    pub fn subscribe(self: *Self, input: subscribe_.SubscribeInput, options: subscribe_.Options) !subscribe_.SubscribeOutput {
        return subscribe_.execute(self, input, options);
    }

    /// Add tags to the specified Amazon SNS topic. For an overview, see [Amazon SNS
    /// Tags](https://docs.aws.amazon.com/sns/latest/dg/sns-tags.html) in the
    /// *Amazon SNS Developer Guide*.
    ///
    /// When you use topic tags, keep the following guidelines in mind:
    ///
    /// * Adding more than 50 tags to a topic isn't recommended.
    ///
    /// * Tags don't have any semantic meaning. Amazon SNS interprets tags as
    ///   character
    /// strings.
    ///
    /// * Tags are case-sensitive.
    ///
    /// * A new tag with a key identical to that of an existing tag overwrites the
    /// existing tag.
    ///
    /// * Tagging actions are limited to 10 TPS per Amazon Web Services account, per
    ///   Amazon Web Services Region. If
    /// your application requires a higher throughput, file a [technical support
    /// request](https://console.aws.amazon.com/support/home#/case/create?issueType=technical).
    pub fn tagResource(self: *Self, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, input, options);
    }

    /// Deletes a subscription. If the subscription requires authentication for
    /// deletion, only
    /// the owner of the subscription or the topic's owner can unsubscribe, and an
    /// Amazon Web Services
    /// signature is required. If the `Unsubscribe` call does not require
    /// authentication and the requester is not the subscription owner, a final
    /// cancellation
    /// message is delivered to the endpoint, so that the endpoint owner can easily
    /// resubscribe
    /// to the topic if the `Unsubscribe` request was unintended.
    ///
    /// This action is throttled at 100 transactions per second (TPS).
    pub fn unsubscribe(self: *Self, input: unsubscribe_.UnsubscribeInput, options: unsubscribe_.Options) !unsubscribe_.UnsubscribeOutput {
        return unsubscribe_.execute(self, input, options);
    }

    /// Remove tags from the specified Amazon SNS topic. For an overview, see
    /// [Amazon SNS Tags](https://docs.aws.amazon.com/sns/latest/dg/sns-tags.html)
    /// in the
    /// *Amazon SNS Developer Guide*.
    pub fn untagResource(self: *Self, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, input, options);
    }

    /// Verifies a destination phone number with a one-time password (OTP) for the
    /// calling
    /// Amazon Web Services account.
    ///
    /// When you start using Amazon SNS to send SMS messages, your Amazon Web
    /// Services account is in the
    /// *SMS sandbox*. The SMS sandbox provides a safe environment for
    /// you to try Amazon SNS features without risking your reputation as an SMS
    /// sender. While your
    /// Amazon Web Services account is in the SMS sandbox, you can use all of the
    /// features of Amazon SNS. However, you can send
    /// SMS messages only to verified destination phone numbers. For more
    /// information, including how to
    /// move out of the sandbox to send messages without restrictions,
    /// see [SMS
    /// sandbox](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html) in
    /// the *Amazon SNS Developer Guide*.
    pub fn verifySmsSandboxPhoneNumber(self: *Self, input: verify_sms_sandbox_phone_number.VerifySMSSandboxPhoneNumberInput, options: verify_sms_sandbox_phone_number.Options) !verify_sms_sandbox_phone_number.VerifySMSSandboxPhoneNumberOutput {
        return verify_sms_sandbox_phone_number.execute(self, input, options);
    }
};
