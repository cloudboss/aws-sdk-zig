const aws = @import("aws");
const std = @import("std");

const describe_report_creation = @import("describe_report_creation.zig");
const get_compliance_summary = @import("get_compliance_summary.zig");
const get_resources = @import("get_resources.zig");
const get_tag_keys = @import("get_tag_keys.zig");
const get_tag_values = @import("get_tag_values.zig");
const list_required_tags = @import("list_required_tags.zig");
const start_report_creation = @import("start_report_creation.zig");
const tag_resources = @import("tag_resources.zig");
const untag_resources = @import("untag_resources.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Resource Groups Tagging API";

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

    /// Describes the status of the `StartReportCreation` operation.
    ///
    /// You can call this operation only from the organization's
    /// management account and from the us-east-1 Region.
    pub fn describeReportCreation(self: *Self, allocator: std.mem.Allocator, input: describe_report_creation.DescribeReportCreationInput, options: describe_report_creation.Options) !describe_report_creation.DescribeReportCreationOutput {
        return describe_report_creation.execute(self, allocator, input, options);
    }

    /// Returns a table that shows counts of resources that are noncompliant with
    /// their tag
    /// policies.
    ///
    /// For more information on tag policies, see [Tag
    /// Policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_tag-policies.html) in
    /// the *Organizations User Guide.*
    ///
    /// You can call this operation only from the organization's
    /// management account and from the us-east-1 Region.
    ///
    /// This operation supports pagination, where the response can be sent in
    /// multiple pages. You should check the `PaginationToken` response parameter to
    /// determine
    /// if there are additional results available to return. Repeat the query,
    /// passing the
    /// `PaginationToken` response parameter value as an input to the next request
    /// until you
    /// recieve a `null` value. A null value for `PaginationToken` indicates that
    /// there are no more results waiting to be returned.
    pub fn getComplianceSummary(self: *Self, allocator: std.mem.Allocator, input: get_compliance_summary.GetComplianceSummaryInput, options: get_compliance_summary.Options) !get_compliance_summary.GetComplianceSummaryOutput {
        return get_compliance_summary.execute(self, allocator, input, options);
    }

    /// Returns all the tagged or previously tagged resources that are located in
    /// the
    /// specified Amazon Web Services Region for the account.
    ///
    /// Depending on what information you want returned, you can also specify the
    /// following:
    ///
    /// * *Filters* that specify what tags and resource types you
    /// want returned. The response includes all tags that are associated with the
    /// requested resources.
    ///
    /// * Information about compliance with the account's effective tag policy. For
    ///   more
    /// information on tag policies, see [Tag
    /// Policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_tag-policies.html) in the *Organizations User Guide.*
    ///
    /// This operation supports pagination, where the response can be sent in
    /// multiple pages. You should check the `PaginationToken` response parameter to
    /// determine
    /// if there are additional results available to return. Repeat the query,
    /// passing the
    /// `PaginationToken` response parameter value as an input to the next request
    /// until you
    /// recieve a `null` value. A null value for `PaginationToken` indicates that
    /// there are no more results waiting to be returned.
    ///
    /// `GetResources` does not return untagged resources.
    ///
    /// To find untagged resources in your account, use Amazon Web Services Resource
    /// Explorer with a
    /// query that uses `tag:none`. For more information, see [ Search query syntax
    /// reference for Resource
    /// Explorer](https://docs.aws.amazon.com/resource-explorer/latest/userguide/using-search-query-syntax.html).
    pub fn getResources(self: *Self, allocator: std.mem.Allocator, input: get_resources.GetResourcesInput, options: get_resources.Options) !get_resources.GetResourcesOutput {
        return get_resources.execute(self, allocator, input, options);
    }

    /// Returns all tag keys currently in use in the specified Amazon Web Services
    /// Region for the calling
    /// account.
    ///
    /// This operation supports pagination, where the response can be sent in
    /// multiple pages. You should check the `PaginationToken` response parameter to
    /// determine
    /// if there are additional results available to return. Repeat the query,
    /// passing the
    /// `PaginationToken` response parameter value as an input to the next request
    /// until you
    /// recieve a `null` value. A null value for `PaginationToken` indicates that
    /// there are no more results waiting to be returned.
    pub fn getTagKeys(self: *Self, allocator: std.mem.Allocator, input: get_tag_keys.GetTagKeysInput, options: get_tag_keys.Options) !get_tag_keys.GetTagKeysOutput {
        return get_tag_keys.execute(self, allocator, input, options);
    }

    /// Returns all tag values for the specified key that are used in the specified
    /// Amazon Web Services
    /// Region for the calling account.
    ///
    /// This operation supports pagination, where the response can be sent in
    /// multiple pages. You should check the `PaginationToken` response parameter to
    /// determine
    /// if there are additional results available to return. Repeat the query,
    /// passing the
    /// `PaginationToken` response parameter value as an input to the next request
    /// until you
    /// recieve a `null` value. A null value for `PaginationToken` indicates that
    /// there are no more results waiting to be returned.
    pub fn getTagValues(self: *Self, allocator: std.mem.Allocator, input: get_tag_values.GetTagValuesInput, options: get_tag_values.Options) !get_tag_values.GetTagValuesOutput {
        return get_tag_values.execute(self, allocator, input, options);
    }

    /// Lists the required tags for supported resource types in an Amazon Web
    /// Services account.
    pub fn listRequiredTags(self: *Self, allocator: std.mem.Allocator, input: list_required_tags.ListRequiredTagsInput, options: list_required_tags.Options) !list_required_tags.ListRequiredTagsOutput {
        return list_required_tags.execute(self, allocator, input, options);
    }

    /// Generates a report that lists all tagged resources in the accounts across
    /// your
    /// organization and tells whether each resource is compliant with the effective
    /// tag policy.
    /// Compliance data is refreshed daily. The report is generated asynchronously.
    ///
    /// The generated report is saved to the following location:
    ///
    /// `s3://amzn-s3-demo-bucket/AwsTagPolicies/o-exampleorgid/YYYY-MM-ddTHH:mm:ssZ/report.csv`
    ///
    /// For more information about evaluating resource compliance with tag policies,
    /// including
    /// the required permissions, review [Permissions for evaluating
    /// organization-wide
    /// compliance](https://docs.aws.amazon.com/tag-editor/latest/userguide/tag-policies-orgs.html#tag-policies-permissions-org) in the
    /// *Tagging Amazon Web Services Resources and Tag Editor* user guide.
    ///
    /// You can call this operation only from the organization's
    /// management account and from the us-east-1 Region.
    ///
    /// If the account associated with the identity used to call
    /// `StartReportCreation` is different from the account that owns the Amazon S3
    /// bucket, there must be a bucket policy attached to the bucket to provide
    /// access. For more
    /// information, review [Amazon S3 bucket
    /// policy for report
    /// storage](https://docs.aws.amazon.com/tag-editor/latest/userguide/tag-policies-orgs.html#bucket-policy) in the *Tagging Amazon Web Services Resources and Tag
    /// Editor* user guide.
    pub fn startReportCreation(self: *Self, allocator: std.mem.Allocator, input: start_report_creation.StartReportCreationInput, options: start_report_creation.Options) !start_report_creation.StartReportCreationOutput {
        return start_report_creation.execute(self, allocator, input, options);
    }

    /// Applies one or more tags to the specified resources. Note the following:
    ///
    /// * Not all resources can have tags. For a list of services with resources
    ///   that
    /// support tagging using this operation, see [Services that support the
    /// Resource Groups Tagging
    /// API](https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/supported-services.html). If the resource doesn't yet support
    /// this operation, the resource's service might support tagging using its own
    /// API
    /// operations. For more information, refer to the documentation for that
    /// service.
    ///
    /// * Each resource can have up to 50 tags. For other limits, see [Tag Naming
    ///   and Usage
    ///   Conventions](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html#tag-conventions) in the *Amazon Web Services General
    /// Reference.*
    ///
    /// * You can only tag resources that are located in the specified Amazon Web
    ///   Services Region for
    /// the Amazon Web Services account.
    ///
    /// * To add tags to a resource, you need the necessary permissions for the
    ///   service
    /// that the resource belongs to as well as permissions for adding tags. For
    /// more
    /// information, see the documentation for each service.
    ///
    /// * When you use the [Amazon Web Services Resource
    /// Groups Tagging
    /// API](https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/overview.html) to update tags for Amazon Web Services CloudFormation stack
    /// sets, Amazon Web Services calls the [Amazon Web Services
    /// CloudFormation `UpdateStack`
    /// ](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_UpdateStack.html) operation. This operation
    /// may initiate additional resource property updates in addition to the desired
    /// tag
    /// updates. To avoid unexpected resource updates, Amazon Web Services
    /// recommends that you only
    /// apply or update tags to your CloudFormation stack sets using Amazon Web
    /// Services
    /// CloudFormation.
    ///
    /// Do not store personally identifiable information (PII) or other confidential
    /// or
    /// sensitive information in tags. We use tags to provide you with billing and
    /// administration services. Tags are not intended to be used for private or
    /// sensitive
    /// data.
    ///
    /// **Minimum permissions**
    ///
    /// In addition to the `tag:TagResources` permission required by this
    /// operation, you must also have the tagging permission defined by the service
    /// that created
    /// the resource. For example, to tag an Amazon EC2 instance using the
    /// `TagResources`
    /// operation, you must have both of the following permissions:
    ///
    /// * `tag:TagResources`
    ///
    /// * `ec2:CreateTags`
    ///
    /// In addition, some services might have specific requirements for tagging some
    /// types
    /// of resources. For example, to tag an Amazon S3 bucket, you must also have
    /// the
    /// `s3:GetBucketTagging` permission. If the expected minimum permissions
    /// don't work, check the documentation for that service's tagging APIs for more
    /// information.
    pub fn tagResources(self: *Self, allocator: std.mem.Allocator, input: tag_resources.TagResourcesInput, options: tag_resources.Options) !tag_resources.TagResourcesOutput {
        return tag_resources.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resources. When you specify a
    /// tag key,
    /// the action removes both that key and its associated value. The operation
    /// succeeds even
    /// if you attempt to remove tags from a resource that were already removed.
    /// Note the
    /// following:
    ///
    /// * To remove tags from a resource, you need the necessary permissions for the
    /// service that the resource belongs to as well as permissions for removing
    /// tags.
    /// For more information, see the documentation for the service whose resource
    /// you
    /// want to untag.
    ///
    /// * You can only tag resources that are located in the specified Amazon Web
    ///   Services Region for
    /// the calling Amazon Web Services account.
    ///
    /// **Minimum permissions**
    ///
    /// In addition to the `tag:UntagResources` permission required by this
    /// operation, you must also have the remove tags permission defined by the
    /// service that
    /// created the resource. For example, to remove the tags from an Amazon EC2
    /// instance using the
    /// `UntagResources` operation, you must have both of the following
    /// permissions:
    ///
    /// * `tag:UntagResources`
    ///
    /// * `ec2:DeleteTags`
    ///
    /// In addition, some services might have specific requirements for untagging
    /// some
    /// types of resources. For example, to untag Amazon Web Services Glue
    /// Connection, you must also have the
    /// `glue:GetConnection` permission. If the expected minimum permissions
    /// don't work, check the documentation for that service's tagging APIs for more
    /// information.
    pub fn untagResources(self: *Self, allocator: std.mem.Allocator, input: untag_resources.UntagResourcesInput, options: untag_resources.Options) !untag_resources.UntagResourcesOutput {
        return untag_resources.execute(self, allocator, input, options);
    }

    pub fn getComplianceSummaryPaginator(self: *Self, params: get_compliance_summary.GetComplianceSummaryInput) paginator.GetComplianceSummaryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getResourcesPaginator(self: *Self, params: get_resources.GetResourcesInput) paginator.GetResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTagKeysPaginator(self: *Self, params: get_tag_keys.GetTagKeysInput) paginator.GetTagKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTagValuesPaginator(self: *Self, params: get_tag_values.GetTagValuesInput) paginator.GetTagValuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRequiredTagsPaginator(self: *Self, params: list_required_tags.ListRequiredTagsInput) paginator.ListRequiredTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
