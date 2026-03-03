const aws = @import("aws");
const std = @import("std");

const associate_repository = @import("associate_repository.zig");
const create_code_review = @import("create_code_review.zig");
const describe_code_review = @import("describe_code_review.zig");
const describe_recommendation_feedback = @import("describe_recommendation_feedback.zig");
const describe_repository_association = @import("describe_repository_association.zig");
const disassociate_repository = @import("disassociate_repository.zig");
const list_code_reviews = @import("list_code_reviews.zig");
const list_recommendation_feedback = @import("list_recommendation_feedback.zig");
const list_recommendations = @import("list_recommendations.zig");
const list_repository_associations = @import("list_repository_associations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_recommendation_feedback = @import("put_recommendation_feedback.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CodeGuru Reviewer";

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

    /// Use to associate an Amazon Web Services CodeCommit repository or a
    /// repository managed by Amazon Web Services
    /// CodeStar Connections with Amazon CodeGuru Reviewer. When you associate a
    /// repository, CodeGuru Reviewer reviews
    /// source code changes in the repository's pull requests and provides automatic
    /// recommendations. You can view recommendations using the CodeGuru Reviewer
    /// console. For more
    /// information, see [Recommendations in
    /// Amazon CodeGuru
    /// Reviewer](https://docs.aws.amazon.com/codeguru/latest/reviewer-ug/recommendations.html) in the *Amazon CodeGuru Reviewer User Guide.*
    ///
    /// If you associate a CodeCommit or S3 repository, it must be in the same
    /// Amazon Web Services Region and
    /// Amazon Web Services account where its CodeGuru Reviewer code reviews are
    /// configured.
    ///
    /// Bitbucket and GitHub Enterprise Server repositories are managed by Amazon
    /// Web Services CodeStar
    /// Connections to connect to CodeGuru Reviewer. For more information, see
    /// [Associate a
    /// repository](https://docs.aws.amazon.com/codeguru/latest/reviewer-ug/getting-started-associate-repository.html) in the *Amazon CodeGuru Reviewer User Guide.*
    ///
    /// You cannot use the CodeGuru Reviewer SDK or the Amazon Web Services CLI to
    /// associate a GitHub repository with
    /// Amazon CodeGuru Reviewer. To associate a GitHub repository, use the console.
    /// For more information, see
    /// [Getting started with
    /// CodeGuru
    /// Reviewer](https://docs.aws.amazon.com/codeguru/latest/reviewer-ug/getting-started-with-guru.html) in the *CodeGuru Reviewer User Guide.*
    pub fn associateRepository(self: *Self, allocator: std.mem.Allocator, input: associate_repository.AssociateRepositoryInput, options: associate_repository.Options) !associate_repository.AssociateRepositoryOutput {
        return associate_repository.execute(self, allocator, input, options);
    }

    /// Use to create a code review with a
    /// [CodeReviewType](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CodeReviewType.html) of
    /// `RepositoryAnalysis`. This type of code review analyzes all code under a
    /// specified branch in an associated repository. `PullRequest` code reviews are
    /// automatically triggered by a pull request.
    pub fn createCodeReview(self: *Self, allocator: std.mem.Allocator, input: create_code_review.CreateCodeReviewInput, options: create_code_review.Options) !create_code_review.CreateCodeReviewOutput {
        return create_code_review.execute(self, allocator, input, options);
    }

    /// Returns the metadata associated with the code review along with its status.
    pub fn describeCodeReview(self: *Self, allocator: std.mem.Allocator, input: describe_code_review.DescribeCodeReviewInput, options: describe_code_review.Options) !describe_code_review.DescribeCodeReviewOutput {
        return describe_code_review.execute(self, allocator, input, options);
    }

    /// Describes the customer feedback for a CodeGuru Reviewer recommendation.
    pub fn describeRecommendationFeedback(self: *Self, allocator: std.mem.Allocator, input: describe_recommendation_feedback.DescribeRecommendationFeedbackInput, options: describe_recommendation_feedback.Options) !describe_recommendation_feedback.DescribeRecommendationFeedbackOutput {
        return describe_recommendation_feedback.execute(self, allocator, input, options);
    }

    /// Returns a
    /// [RepositoryAssociation](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociation.html) object that contains information about the requested
    /// repository association.
    pub fn describeRepositoryAssociation(self: *Self, allocator: std.mem.Allocator, input: describe_repository_association.DescribeRepositoryAssociationInput, options: describe_repository_association.Options) !describe_repository_association.DescribeRepositoryAssociationOutput {
        return describe_repository_association.execute(self, allocator, input, options);
    }

    /// Removes the association between Amazon CodeGuru Reviewer and a repository.
    pub fn disassociateRepository(self: *Self, allocator: std.mem.Allocator, input: disassociate_repository.DisassociateRepositoryInput, options: disassociate_repository.Options) !disassociate_repository.DisassociateRepositoryOutput {
        return disassociate_repository.execute(self, allocator, input, options);
    }

    /// Lists all the code reviews that the customer has created in the past 90
    /// days.
    pub fn listCodeReviews(self: *Self, allocator: std.mem.Allocator, input: list_code_reviews.ListCodeReviewsInput, options: list_code_reviews.Options) !list_code_reviews.ListCodeReviewsOutput {
        return list_code_reviews.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [RecommendationFeedbackSummary](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RecommendationFeedbackSummary.html) objects that contain customer recommendation
    /// feedback for all CodeGuru Reviewer users.
    pub fn listRecommendationFeedback(self: *Self, allocator: std.mem.Allocator, input: list_recommendation_feedback.ListRecommendationFeedbackInput, options: list_recommendation_feedback.Options) !list_recommendation_feedback.ListRecommendationFeedbackOutput {
        return list_recommendation_feedback.execute(self, allocator, input, options);
    }

    /// Returns the list of all recommendations for a completed code review.
    pub fn listRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_recommendations.ListRecommendationsInput, options: list_recommendations.Options) !list_recommendations.ListRecommendationsOutput {
        return list_recommendations.execute(self, allocator, input, options);
    }

    /// Returns a list of
    /// [RepositoryAssociationSummary](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociationSummary.html) objects that contain summary information about a
    /// repository association. You can filter the returned list by
    /// [ProviderType](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociationSummary.html#reviewer-Type-RepositoryAssociationSummary-ProviderType), [Name](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociationSummary.html#reviewer-Type-RepositoryAssociationSummary-Name), [State](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociationSummary.html#reviewer-Type-RepositoryAssociationSummary-State), and [Owner](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociationSummary.html#reviewer-Type-RepositoryAssociationSummary-Owner).
    pub fn listRepositoryAssociations(self: *Self, allocator: std.mem.Allocator, input: list_repository_associations.ListRepositoryAssociationsInput, options: list_repository_associations.Options) !list_repository_associations.ListRepositoryAssociationsOutput {
        return list_repository_associations.execute(self, allocator, input, options);
    }

    /// Returns the list of tags associated with an associated repository resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Stores customer feedback for a CodeGuru Reviewer recommendation. When this
    /// API is called again with
    /// different reactions the previous feedback is overwritten.
    pub fn putRecommendationFeedback(self: *Self, allocator: std.mem.Allocator, input: put_recommendation_feedback.PutRecommendationFeedbackInput, options: put_recommendation_feedback.Options) !put_recommendation_feedback.PutRecommendationFeedbackOutput {
        return put_recommendation_feedback.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to an associated repository.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from an associated repository.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listCodeReviewsPaginator(self: *Self, params: list_code_reviews.ListCodeReviewsInput) paginator.ListCodeReviewsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecommendationFeedbackPaginator(self: *Self, params: list_recommendation_feedback.ListRecommendationFeedbackInput) paginator.ListRecommendationFeedbackPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecommendationsPaginator(self: *Self, params: list_recommendations.ListRecommendationsInput) paginator.ListRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRepositoryAssociationsPaginator(self: *Self, params: list_repository_associations.ListRepositoryAssociationsInput) paginator.ListRepositoryAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilCodeReviewCompleted(self: *Self, params: describe_code_review.DescribeCodeReviewInput) aws.waiter.WaiterError!void {
        var w = waiters.CodeReviewCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilRepositoryAssociationSucceeded(self: *Self, params: describe_repository_association.DescribeRepositoryAssociationInput) aws.waiter.WaiterError!void {
        var w = waiters.RepositoryAssociationSucceededWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
