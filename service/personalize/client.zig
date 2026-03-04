const aws = @import("aws");
const std = @import("std");

const create_batch_inference_job = @import("create_batch_inference_job.zig");
const create_batch_segment_job = @import("create_batch_segment_job.zig");
const create_campaign = @import("create_campaign.zig");
const create_data_deletion_job = @import("create_data_deletion_job.zig");
const create_dataset = @import("create_dataset.zig");
const create_dataset_export_job = @import("create_dataset_export_job.zig");
const create_dataset_group = @import("create_dataset_group.zig");
const create_dataset_import_job = @import("create_dataset_import_job.zig");
const create_event_tracker = @import("create_event_tracker.zig");
const create_filter = @import("create_filter.zig");
const create_metric_attribution = @import("create_metric_attribution.zig");
const create_recommender = @import("create_recommender.zig");
const create_schema = @import("create_schema.zig");
const create_solution = @import("create_solution.zig");
const create_solution_version = @import("create_solution_version.zig");
const delete_campaign = @import("delete_campaign.zig");
const delete_dataset = @import("delete_dataset.zig");
const delete_dataset_group = @import("delete_dataset_group.zig");
const delete_event_tracker = @import("delete_event_tracker.zig");
const delete_filter = @import("delete_filter.zig");
const delete_metric_attribution = @import("delete_metric_attribution.zig");
const delete_recommender = @import("delete_recommender.zig");
const delete_schema = @import("delete_schema.zig");
const delete_solution = @import("delete_solution.zig");
const describe_algorithm = @import("describe_algorithm.zig");
const describe_batch_inference_job = @import("describe_batch_inference_job.zig");
const describe_batch_segment_job = @import("describe_batch_segment_job.zig");
const describe_campaign = @import("describe_campaign.zig");
const describe_data_deletion_job = @import("describe_data_deletion_job.zig");
const describe_dataset = @import("describe_dataset.zig");
const describe_dataset_export_job = @import("describe_dataset_export_job.zig");
const describe_dataset_group = @import("describe_dataset_group.zig");
const describe_dataset_import_job = @import("describe_dataset_import_job.zig");
const describe_event_tracker = @import("describe_event_tracker.zig");
const describe_feature_transformation = @import("describe_feature_transformation.zig");
const describe_filter = @import("describe_filter.zig");
const describe_metric_attribution = @import("describe_metric_attribution.zig");
const describe_recipe = @import("describe_recipe.zig");
const describe_recommender = @import("describe_recommender.zig");
const describe_schema = @import("describe_schema.zig");
const describe_solution = @import("describe_solution.zig");
const describe_solution_version = @import("describe_solution_version.zig");
const get_solution_metrics = @import("get_solution_metrics.zig");
const list_batch_inference_jobs = @import("list_batch_inference_jobs.zig");
const list_batch_segment_jobs = @import("list_batch_segment_jobs.zig");
const list_campaigns = @import("list_campaigns.zig");
const list_data_deletion_jobs = @import("list_data_deletion_jobs.zig");
const list_dataset_export_jobs = @import("list_dataset_export_jobs.zig");
const list_dataset_groups = @import("list_dataset_groups.zig");
const list_dataset_import_jobs = @import("list_dataset_import_jobs.zig");
const list_datasets = @import("list_datasets.zig");
const list_event_trackers = @import("list_event_trackers.zig");
const list_filters = @import("list_filters.zig");
const list_metric_attribution_metrics = @import("list_metric_attribution_metrics.zig");
const list_metric_attributions = @import("list_metric_attributions.zig");
const list_recipes = @import("list_recipes.zig");
const list_recommenders = @import("list_recommenders.zig");
const list_schemas = @import("list_schemas.zig");
const list_solution_versions = @import("list_solution_versions.zig");
const list_solutions = @import("list_solutions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_recommender = @import("start_recommender.zig");
const stop_recommender = @import("stop_recommender.zig");
const stop_solution_version_creation = @import("stop_solution_version_creation.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_campaign = @import("update_campaign.zig");
const update_dataset = @import("update_dataset.zig");
const update_metric_attribution = @import("update_metric_attribution.zig");
const update_recommender = @import("update_recommender.zig");
const update_solution = @import("update_solution.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Personalize";

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

    /// Generates batch recommendations based on a list of items or users stored in
    /// Amazon S3
    /// and exports the recommendations to an Amazon S3 bucket.
    ///
    /// To generate batch recommendations, specify the ARN of a solution version and
    /// an Amazon S3 URI for the input and output data.
    /// For user personalization, popular items, and personalized ranking solutions,
    /// the batch inference job generates a list of
    /// recommended items for each user ID in the input file. For related items
    /// solutions, the job generates a list of recommended
    /// items for each item ID in the input file.
    ///
    /// For more information, see [Creating a batch inference job
    /// ](https://docs.aws.amazon.com/personalize/latest/dg/getting-batch-recommendations.html).
    ///
    /// If you use the Similar-Items recipe, Amazon Personalize can add descriptive
    /// themes to batch recommendations.
    /// To generate themes, set the job's mode to
    /// `THEME_GENERATION` and specify the name of the field that contains item
    /// names in the
    /// input data.
    ///
    /// For more information about generating themes, see [Batch recommendations
    /// with themes from Content Generator
    /// ](https://docs.aws.amazon.com/personalize/latest/dg/themed-batch-recommendations.html).
    ///
    /// You can't get batch recommendations with the Trending-Now or
    /// Next-Best-Action recipes.
    pub fn createBatchInferenceJob(self: *Self, allocator: std.mem.Allocator, input: create_batch_inference_job.CreateBatchInferenceJobInput, options: CallOptions) !create_batch_inference_job.CreateBatchInferenceJobOutput {
        return create_batch_inference_job.execute(self, allocator, input, options);
    }

    /// Creates a batch segment job. The operation can handle up to 50 million
    /// records and the
    /// input file must be in JSON format. For more information, see
    /// [Getting batch recommendations and user
    /// segments](https://docs.aws.amazon.com/personalize/latest/dg/recommendations-batch.html).
    pub fn createBatchSegmentJob(self: *Self, allocator: std.mem.Allocator, input: create_batch_segment_job.CreateBatchSegmentJobInput, options: CallOptions) !create_batch_segment_job.CreateBatchSegmentJobOutput {
        return create_batch_segment_job.execute(self, allocator, input, options);
    }

    /// You incur campaign costs while it is active. To avoid unnecessary costs,
    /// make sure to delete the campaign when you are finished. For information
    /// about campaign
    /// costs, see [Amazon Personalize
    /// pricing](https://aws.amazon.com/personalize/pricing/).
    ///
    /// Creates a campaign that deploys a solution version. When a client calls the
    /// [GetRecommendations](https://docs.aws.amazon.com/personalize/latest/dg/API_RS_GetRecommendations.html)
    /// and
    /// [GetPersonalizedRanking](https://docs.aws.amazon.com/personalize/latest/dg/API_RS_GetPersonalizedRanking.html)
    /// APIs, a campaign is specified in the request.
    ///
    /// **Minimum Provisioned TPS and Auto-Scaling**
    ///
    /// A high `minProvisionedTPS` will increase your cost. We recommend starting
    /// with 1 for `minProvisionedTPS` (the default). Track
    /// your usage using Amazon CloudWatch metrics, and increase the
    /// `minProvisionedTPS`
    /// as necessary.
    ///
    /// When you create an Amazon Personalize campaign, you can specify the minimum
    /// provisioned transactions per second
    /// (`minProvisionedTPS`) for the campaign. This is the baseline transaction
    /// throughput for the campaign provisioned by
    /// Amazon Personalize. It sets the minimum billing charge for the campaign
    /// while it is active. A transaction is a single `GetRecommendations` or
    /// `GetPersonalizedRanking` request. The default `minProvisionedTPS` is 1.
    ///
    /// If your TPS increases beyond the `minProvisionedTPS`, Amazon Personalize
    /// auto-scales the provisioned capacity up
    /// and down, but never below `minProvisionedTPS`.
    /// There's a short time delay while the capacity is increased
    /// that might cause loss of transactions. When your traffic reduces, capacity
    /// returns to the `minProvisionedTPS`.
    ///
    /// You are charged for the
    /// the minimum provisioned TPS or, if your requests exceed the
    /// `minProvisionedTPS`, the actual TPS.
    /// The actual TPS is the total number of recommendation requests you make.
    /// We recommend starting with a low `minProvisionedTPS`, track
    /// your usage using Amazon CloudWatch metrics, and then increase the
    /// `minProvisionedTPS` as necessary.
    ///
    /// For more information about campaign costs, see [Amazon Personalize
    /// pricing](https://aws.amazon.com/personalize/pricing/).
    ///
    /// **Status**
    ///
    /// A campaign can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    ///
    /// To get the campaign status, call
    /// [DescribeCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeCampaign.html).
    ///
    /// Wait until the `status` of the campaign
    /// is `ACTIVE` before asking the campaign for recommendations.
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [ListCampaigns](https://docs.aws.amazon.com/personalize/latest/dg/API_ListCampaigns.html)
    ///
    /// *
    ///   [DescribeCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeCampaign.html)
    ///
    /// *
    ///   [UpdateCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_UpdateCampaign.html)
    ///
    /// *
    ///   [DeleteCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_DeleteCampaign.html)
    pub fn createCampaign(self: *Self, allocator: std.mem.Allocator, input: create_campaign.CreateCampaignInput, options: CallOptions) !create_campaign.CreateCampaignOutput {
        return create_campaign.execute(self, allocator, input, options);
    }

    /// Creates a batch job that deletes all
    /// references to specific users from an Amazon Personalize dataset group in
    /// batches. You specify the users to delete in a CSV file of userIds in
    /// an Amazon S3 bucket. After a job completes, Amazon Personalize no longer
    /// trains
    /// on the users’ data and no longer considers the users when generating user
    /// segments.
    /// For more information about creating a data deletion job, see [Deleting
    /// users](https://docs.aws.amazon.com/personalize/latest/dg/delete-records.html).
    ///
    /// * Your input file must be a CSV file with a single USER_ID column that lists
    ///   the users IDs. For more information
    /// about preparing the CSV file, see [Preparing your data deletion file and
    /// uploading it to Amazon
    /// S3](https://docs.aws.amazon.com/personalize/latest/dg/prepare-deletion-input-file.html).
    ///
    /// * To give Amazon Personalize permission to access your input CSV file of
    ///   userIds, you must specify an IAM service role that has permission to
    /// read from the data source. This role
    /// needs `GetObject` and `ListBucket` permissions for the bucket and its
    /// content.
    /// These permissions are the same as importing data. For information on
    /// granting access to your Amazon S3
    /// bucket, see [Giving
    /// Amazon Personalize Access to Amazon S3
    /// Resources](https://docs.aws.amazon.com/personalize/latest/dg/granting-personalize-s3-access.html).
    ///
    /// After you create a job, it can take up to a day to delete all references to
    /// the users from datasets and models. Until the job completes,
    /// Amazon Personalize continues to use the data when training. And if you use a
    /// User Segmentation recipe, the users might appear in user segments.
    ///
    /// **Status**
    ///
    /// A data deletion job can have one of the following statuses:
    ///
    /// * PENDING > IN_PROGRESS > COMPLETED -or- FAILED
    ///
    /// To get the status of the data deletion job, call
    /// [DescribeDataDeletionJob](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDataDeletionJob.html) API operation and specify the Amazon Resource Name
    /// (ARN) of the job. If the status is FAILED, the response
    /// includes a `failureReason` key, which describes why the job
    /// failed.
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [ListDataDeletionJobs](https://docs.aws.amazon.com/personalize/latest/dg/API_ListDataDeletionJobs.html)
    ///
    /// *
    ///   [DescribeDataDeletionJob](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDataDeletionJob.html)
    pub fn createDataDeletionJob(self: *Self, allocator: std.mem.Allocator, input: create_data_deletion_job.CreateDataDeletionJobInput, options: CallOptions) !create_data_deletion_job.CreateDataDeletionJobOutput {
        return create_data_deletion_job.execute(self, allocator, input, options);
    }

    /// Creates an empty dataset and adds it to the specified dataset group.
    /// Use
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetImportJob.html) to import your training data to a
    /// dataset.
    ///
    /// There are 5 types of datasets:
    ///
    /// * Item interactions
    ///
    /// * Items
    ///
    /// * Users
    ///
    /// * Action interactions
    ///
    /// * Actions
    ///
    /// Each dataset type has an associated schema with required field types.
    /// Only the `Item interactions` dataset is required in order to train a
    /// model (also referred to as creating a solution).
    ///
    /// A dataset can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE
    /// FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    ///
    /// To get the status of the dataset, call
    /// [DescribeDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDataset.html).
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [CreateDatasetGroup](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetGroup.html)
    ///
    /// *
    ///   [ListDatasets](https://docs.aws.amazon.com/personalize/latest/dg/API_ListDatasets.html)
    ///
    /// *
    ///   [DescribeDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDataset.html)
    ///
    /// *
    ///   [DeleteDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_DeleteDataset.html)
    pub fn createDataset(self: *Self, allocator: std.mem.Allocator, input: create_dataset.CreateDatasetInput, options: CallOptions) !create_dataset.CreateDatasetOutput {
        return create_dataset.execute(self, allocator, input, options);
    }

    /// Creates a job that exports data from your dataset to an Amazon S3 bucket.
    /// To allow Amazon Personalize to export the training data, you must specify an
    /// service-linked IAM role that gives Amazon Personalize `PutObject`
    /// permissions for your Amazon S3 bucket. For information, see [Exporting a
    /// dataset](https://docs.aws.amazon.com/personalize/latest/dg/export-data.html)
    /// in the Amazon Personalize developer guide.
    ///
    /// **Status**
    ///
    /// A dataset export job can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE
    /// FAILED
    ///
    /// To get the status of the export job, call
    /// [DescribeDatasetExportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDatasetExportJob.html), and specify the Amazon Resource Name
    /// (ARN) of the dataset export job. The dataset export is complete when the
    /// status shows as ACTIVE. If the status shows as CREATE FAILED, the response
    /// includes a `failureReason` key, which describes why the job
    /// failed.
    pub fn createDatasetExportJob(self: *Self, allocator: std.mem.Allocator, input: create_dataset_export_job.CreateDatasetExportJobInput, options: CallOptions) !create_dataset_export_job.CreateDatasetExportJobOutput {
        return create_dataset_export_job.execute(self, allocator, input, options);
    }

    /// Creates an empty dataset group. A dataset group is a container for
    /// Amazon Personalize resources. A dataset group can contain at most three
    /// datasets, one
    /// for each type of dataset:
    ///
    /// * Item interactions
    ///
    /// * Items
    ///
    /// * Users
    ///
    /// * Actions
    ///
    /// * Action interactions
    ///
    /// A dataset group can be a Domain dataset group, where you specify a
    /// domain and use pre-configured resources like recommenders, or a
    /// Custom dataset group, where you use custom resources, such as a solution
    /// with a solution version, that you deploy with a campaign. If you start
    /// with a Domain dataset group, you can still add custom resources such as
    /// solutions and solution versions trained with recipes for custom use cases
    /// and deployed with campaigns.
    ///
    /// A dataset group can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE
    /// FAILED
    ///
    /// * DELETE PENDING
    ///
    /// To get the status of the dataset group, call
    /// [DescribeDatasetGroup](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDatasetGroup.html). If the status shows as CREATE FAILED, the
    /// response includes a `failureReason` key, which describes why
    /// the creation failed.
    ///
    /// You must wait until the `status` of the dataset group is
    /// `ACTIVE` before adding a dataset to the group.
    ///
    /// You can specify an Key Management Service (KMS) key to encrypt the datasets
    /// in
    /// the group. If you specify a KMS key, you must also include an Identity and
    /// Access Management
    /// (IAM) role that has permission to access the key.
    ///
    /// **APIs that require a dataset group ARN in the request**
    ///
    /// *
    ///   [CreateDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDataset.html)
    ///
    /// *
    ///   [CreateEventTracker](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateEventTracker.html)
    ///
    /// *
    ///   [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html)
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [ListDatasetGroups](https://docs.aws.amazon.com/personalize/latest/dg/API_ListDatasetGroups.html)
    ///
    /// *
    ///   [DescribeDatasetGroup](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDatasetGroup.html)
    ///
    /// *
    ///   [DeleteDatasetGroup](https://docs.aws.amazon.com/personalize/latest/dg/API_DeleteDatasetGroup.html)
    pub fn createDatasetGroup(self: *Self, allocator: std.mem.Allocator, input: create_dataset_group.CreateDatasetGroupInput, options: CallOptions) !create_dataset_group.CreateDatasetGroupOutput {
        return create_dataset_group.execute(self, allocator, input, options);
    }

    /// Creates a job that imports training data from your data source (an
    /// Amazon S3 bucket) to an Amazon Personalize dataset. To allow Amazon
    /// Personalize to import the
    /// training data, you must specify an IAM service role that has permission to
    /// read from the data source, as Amazon Personalize makes a copy of your data
    /// and
    /// processes it internally. For information on granting access to your Amazon
    /// S3
    /// bucket, see [Giving
    /// Amazon Personalize Access to Amazon S3
    /// Resources](https://docs.aws.amazon.com/personalize/latest/dg/granting-personalize-s3-access.html).
    ///
    /// If you already created a recommender or deployed a custom solution version
    /// with a campaign, how new bulk records
    /// influence recommendations depends on the domain use case or recipe that you
    /// use. For more information, see [How new data influences
    /// real-time
    /// recommendations](https://docs.aws.amazon.com/personalize/latest/dg/how-new-data-influences-recommendations.html).
    ///
    /// By default, a dataset import job replaces any existing data in the
    /// dataset that you imported in bulk. To add new records without replacing
    /// existing data, specify INCREMENTAL for the import mode in the
    /// CreateDatasetImportJob operation.
    ///
    /// **Status**
    ///
    /// A dataset import job can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE
    /// FAILED
    ///
    /// To get the status of the import job, call
    /// [DescribeDatasetImportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDatasetImportJob.html), providing the Amazon Resource Name
    /// (ARN) of the dataset import job. The dataset import is complete when the
    /// status shows as ACTIVE. If the status shows as CREATE FAILED, the response
    /// includes a `failureReason` key, which describes why the job
    /// failed.
    ///
    /// Importing takes time. You must wait until the status shows as ACTIVE
    /// before training a model using the dataset.
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [ListDatasetImportJobs](https://docs.aws.amazon.com/personalize/latest/dg/API_ListDatasetImportJobs.html)
    ///
    /// *
    ///   [DescribeDatasetImportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDatasetImportJob.html)
    pub fn createDatasetImportJob(self: *Self, allocator: std.mem.Allocator, input: create_dataset_import_job.CreateDatasetImportJobInput, options: CallOptions) !create_dataset_import_job.CreateDatasetImportJobOutput {
        return create_dataset_import_job.execute(self, allocator, input, options);
    }

    /// Creates an event tracker that you use when adding event data to a specified
    /// dataset
    /// group using the
    /// [PutEvents](https://docs.aws.amazon.com/personalize/latest/dg/API_UBS_PutEvents.html) API.
    ///
    /// Only one event tracker can be associated with a dataset group. You will get
    /// an error if you call `CreateEventTracker` using the same dataset group as an
    /// existing event tracker.
    ///
    /// When you create an event tracker, the response includes a tracking ID, which
    /// you pass as a parameter when you use the
    /// [PutEvents](https://docs.aws.amazon.com/personalize/latest/dg/API_UBS_PutEvents.html) operation.
    /// Amazon Personalize then appends the event data to the Item interactions
    /// dataset of the dataset group you specify
    /// in your event tracker.
    ///
    /// The event tracker can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    ///
    /// To get the status of the event tracker, call
    /// [DescribeEventTracker](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeEventTracker.html).
    ///
    /// The event tracker must be in the ACTIVE state before using the tracking ID.
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [ListEventTrackers](https://docs.aws.amazon.com/personalize/latest/dg/API_ListEventTrackers.html)
    ///
    /// *
    ///   [DescribeEventTracker](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeEventTracker.html)
    ///
    /// *
    ///   [DeleteEventTracker](https://docs.aws.amazon.com/personalize/latest/dg/API_DeleteEventTracker.html)
    pub fn createEventTracker(self: *Self, allocator: std.mem.Allocator, input: create_event_tracker.CreateEventTrackerInput, options: CallOptions) !create_event_tracker.CreateEventTrackerOutput {
        return create_event_tracker.execute(self, allocator, input, options);
    }

    /// Creates a recommendation filter. For more information, see [Filtering
    /// recommendations and user
    /// segments](https://docs.aws.amazon.com/personalize/latest/dg/filter.html).
    pub fn createFilter(self: *Self, allocator: std.mem.Allocator, input: create_filter.CreateFilterInput, options: CallOptions) !create_filter.CreateFilterOutput {
        return create_filter.execute(self, allocator, input, options);
    }

    /// Creates a metric attribution.
    /// A metric attribution creates reports on the data that you import into Amazon
    /// Personalize. Depending on how you imported the data, you can view reports in
    /// Amazon CloudWatch or Amazon S3.
    /// For more information, see [Measuring impact of
    /// recommendations](https://docs.aws.amazon.com/personalize/latest/dg/measuring-recommendation-impact.html).
    pub fn createMetricAttribution(self: *Self, allocator: std.mem.Allocator, input: create_metric_attribution.CreateMetricAttributionInput, options: CallOptions) !create_metric_attribution.CreateMetricAttributionOutput {
        return create_metric_attribution.execute(self, allocator, input, options);
    }

    /// Creates a recommender with the recipe (a Domain dataset group use case) you
    /// specify.
    /// You create recommenders for a Domain dataset group and specify the
    /// recommender's Amazon Resource Name (ARN) when you make a
    /// [GetRecommendations](https://docs.aws.amazon.com/personalize/latest/dg/API_RS_GetRecommendations.html)
    /// request.
    ///
    /// **Minimum recommendation requests per second**
    ///
    /// A high `minRecommendationRequestsPerSecond` will increase your bill. We
    /// recommend starting with 1 for `minRecommendationRequestsPerSecond` (the
    /// default). Track
    /// your usage using Amazon CloudWatch metrics, and increase the
    /// `minRecommendationRequestsPerSecond`
    /// as necessary.
    ///
    /// When you create a recommender, you can configure the recommender's minimum
    /// recommendation requests per second. The minimum recommendation requests per
    /// second
    /// (`minRecommendationRequestsPerSecond`) specifies the baseline recommendation
    /// request throughput provisioned by
    /// Amazon Personalize. The default minRecommendationRequestsPerSecond is `1`. A
    /// recommendation request is a single `GetRecommendations` operation.
    /// Request throughput is measured in requests per second and Amazon Personalize
    /// uses your requests per second to derive
    /// your requests per hour and the price of your recommender usage.
    ///
    /// If your requests per second increases beyond
    /// `minRecommendationRequestsPerSecond`, Amazon Personalize auto-scales the
    /// provisioned capacity up and down,
    /// but never below `minRecommendationRequestsPerSecond`.
    /// There's a short time delay while the capacity is increased that might cause
    /// loss of
    /// requests.
    ///
    /// Your bill is the greater of either the minimum requests per hour (based on
    /// minRecommendationRequestsPerSecond)
    /// or the actual number of requests. The actual request throughput used is
    /// calculated as the average requests/second within a one-hour window.
    ///
    /// We recommend starting with the default `minRecommendationRequestsPerSecond`,
    /// track
    /// your usage using Amazon CloudWatch metrics, and then increase the
    /// `minRecommendationRequestsPerSecond`
    /// as necessary.
    ///
    /// **Status**
    ///
    /// A recommender can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * STOP PENDING > STOP IN_PROGRESS > INACTIVE > START PENDING > START
    ///   IN_PROGRESS > ACTIVE
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    ///
    /// To get the recommender status, call
    /// [DescribeRecommender](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeRecommender.html).
    ///
    /// Wait until the `status` of the recommender
    /// is `ACTIVE` before asking the recommender for recommendations.
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [ListRecommenders](https://docs.aws.amazon.com/personalize/latest/dg/API_ListRecommenders.html)
    ///
    /// *
    ///   [DescribeRecommender](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeRecommender.html)
    ///
    /// *
    ///   [UpdateRecommender](https://docs.aws.amazon.com/personalize/latest/dg/API_UpdateRecommender.html)
    ///
    /// *
    ///   [DeleteRecommender](https://docs.aws.amazon.com/personalize/latest/dg/API_DeleteRecommender.html)
    pub fn createRecommender(self: *Self, allocator: std.mem.Allocator, input: create_recommender.CreateRecommenderInput, options: CallOptions) !create_recommender.CreateRecommenderOutput {
        return create_recommender.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Personalize schema from the specified schema string. The
    /// schema you create
    /// must be in Avro JSON format.
    ///
    /// Amazon Personalize recognizes three schema variants. Each schema is
    /// associated with a dataset
    /// type and has a set of required field and keywords. If you are creating a
    /// schema for a dataset in a Domain dataset group, you
    /// provide the domain of the Domain dataset group.
    /// You specify a schema when you call
    /// [CreateDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDataset.html).
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [ListSchemas](https://docs.aws.amazon.com/personalize/latest/dg/API_ListSchemas.html)
    ///
    /// *
    ///   [DescribeSchema](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSchema.html)
    ///
    /// *
    ///   [DeleteSchema](https://docs.aws.amazon.com/personalize/latest/dg/API_DeleteSchema.html)
    pub fn createSchema(self: *Self, allocator: std.mem.Allocator, input: create_schema.CreateSchemaInput, options: CallOptions) !create_schema.CreateSchemaOutput {
        return create_schema.execute(self, allocator, input, options);
    }

    /// By default, all new solutions use automatic training. With automatic
    /// training, you incur training costs while
    /// your solution is active. To avoid unnecessary costs, when you are finished
    /// you can
    /// [update the
    /// solution](https://docs.aws.amazon.com/personalize/latest/dg/API_UpdateSolution.html) to turn off automatic training.
    /// For information about training
    /// costs, see [Amazon Personalize
    /// pricing](https://aws.amazon.com/personalize/pricing/).
    ///
    /// Creates the configuration for training a model (creating a solution
    /// version). This configuration
    /// includes the recipe to use for model training and optional training
    /// configuration, such as columns to use
    /// in training and feature transformation parameters. For more information
    /// about configuring a solution, see [Creating and configuring a
    /// solution](https://docs.aws.amazon.com/personalize/latest/dg/customizing-solution-config.html).
    ///
    /// By default, new solutions use automatic training to create solution versions
    /// every 7 days. You can change the training frequency.
    /// Automatic solution version creation starts within one hour after the
    /// solution is ACTIVE. If you manually create a solution version within
    /// the hour, the solution skips the first automatic training. For more
    /// information,
    /// see [Configuring automatic
    /// training](https://docs.aws.amazon.com/personalize/latest/dg/solution-config-auto-training.html).
    ///
    /// To turn off automatic training, set `performAutoTraining` to false. If you
    /// turn off automatic training, you must manually create a solution version
    /// by calling the
    /// [CreateSolutionVersion](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolutionVersion.html) operation.
    ///
    /// After training starts, you can
    /// get the solution version's Amazon Resource Name (ARN) with the
    /// [ListSolutionVersions](https://docs.aws.amazon.com/personalize/latest/dg/API_ListSolutionVersions.html) API operation.
    /// To get its status, use the
    /// [DescribeSolutionVersion](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolutionVersion.html).
    ///
    /// After training completes you can evaluate model accuracy by calling
    /// [GetSolutionMetrics](https://docs.aws.amazon.com/personalize/latest/dg/API_GetSolutionMetrics.html). When you are satisfied with the solution version, you
    /// deploy it using
    /// [CreateCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateCampaign.html). The campaign provides recommendations
    /// to a client through the
    /// [GetRecommendations](https://docs.aws.amazon.com/personalize/latest/dg/API_RS_GetRecommendations.html) API.
    ///
    /// Amazon Personalize doesn't support configuring the `hpoObjective`
    /// for solution hyperparameter optimization at this time.
    ///
    /// **Status**
    ///
    /// A solution can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    ///
    /// To get the status of the solution, call
    /// [DescribeSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolution.html). If you use
    /// manual training, the status must be ACTIVE before you call
    /// `CreateSolutionVersion`.
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [UpdateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_UpdateSolution.html)
    ///
    /// *
    ///   [ListSolutions](https://docs.aws.amazon.com/personalize/latest/dg/API_ListSolutions.html)
    ///
    /// *
    ///   [CreateSolutionVersion](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolutionVersion.html)
    ///
    /// *
    ///   [DescribeSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolution.html)
    ///
    /// *
    ///   [DeleteSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_DeleteSolution.html)
    ///
    /// *
    ///   [ListSolutionVersions](https://docs.aws.amazon.com/personalize/latest/dg/API_ListSolutionVersions.html)
    ///
    /// *
    ///   [DescribeSolutionVersion](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolutionVersion.html)
    pub fn createSolution(self: *Self, allocator: std.mem.Allocator, input: create_solution.CreateSolutionInput, options: CallOptions) !create_solution.CreateSolutionOutput {
        return create_solution.execute(self, allocator, input, options);
    }

    /// Trains or retrains an active solution in a Custom dataset group. A solution
    /// is created using the
    /// [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html)
    /// operation and must be in the ACTIVE state before calling
    /// `CreateSolutionVersion`. A new version of the solution is created every time
    /// you
    /// call this operation.
    ///
    /// **Status**
    ///
    /// A solution version can be in one of the following states:
    ///
    /// * CREATE PENDING
    ///
    /// * CREATE IN_PROGRESS
    ///
    /// * ACTIVE
    ///
    /// * CREATE FAILED
    ///
    /// * CREATE STOPPING
    ///
    /// * CREATE STOPPED
    ///
    /// To get the status of the version, call
    /// [DescribeSolutionVersion](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolutionVersion.html). Wait
    /// until the status shows as ACTIVE before calling `CreateCampaign`.
    ///
    /// If the status shows as CREATE FAILED, the response includes a
    /// `failureReason`
    /// key, which describes why the job failed.
    ///
    /// **Related APIs**
    ///
    /// *
    ///   [ListSolutionVersions](https://docs.aws.amazon.com/personalize/latest/dg/API_ListSolutionVersions.html)
    ///
    /// *
    ///   [DescribeSolutionVersion](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolutionVersion.html)
    ///
    /// *
    ///   [ListSolutions](https://docs.aws.amazon.com/personalize/latest/dg/API_ListSolutions.html)
    ///
    /// *
    ///   [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html)
    ///
    /// *
    ///   [DescribeSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolution.html)
    ///
    /// *
    ///   [DeleteSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_DeleteSolution.html)
    pub fn createSolutionVersion(self: *Self, allocator: std.mem.Allocator, input: create_solution_version.CreateSolutionVersionInput, options: CallOptions) !create_solution_version.CreateSolutionVersionOutput {
        return create_solution_version.execute(self, allocator, input, options);
    }

    /// Removes a campaign by deleting the solution deployment. The solution that
    /// the campaign is based on is not deleted and can be redeployed when needed. A
    /// deleted campaign can no
    /// longer be specified in a
    /// [GetRecommendations](https://docs.aws.amazon.com/personalize/latest/dg/API_RS_GetRecommendations.html)
    /// request.
    /// For information on creating campaigns, see
    /// [CreateCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateCampaign.html).
    pub fn deleteCampaign(self: *Self, allocator: std.mem.Allocator, input: delete_campaign.DeleteCampaignInput, options: CallOptions) !delete_campaign.DeleteCampaignOutput {
        return delete_campaign.execute(self, allocator, input, options);
    }

    /// Deletes a dataset. You can't delete a dataset if an associated
    /// `DatasetImportJob` or `SolutionVersion` is in the
    /// CREATE PENDING or IN PROGRESS state. For more information about deleting
    /// datasets,
    /// see [Deleting a
    /// dataset](https://docs.aws.amazon.com/personalize/latest/dg/delete-dataset.html).
    pub fn deleteDataset(self: *Self, allocator: std.mem.Allocator, input: delete_dataset.DeleteDatasetInput, options: CallOptions) !delete_dataset.DeleteDatasetOutput {
        return delete_dataset.execute(self, allocator, input, options);
    }

    /// Deletes a dataset group. Before you delete a dataset group, you must
    /// delete the following:
    ///
    /// * All associated event trackers.
    ///
    /// * All associated solutions.
    ///
    /// * All datasets in the dataset group.
    pub fn deleteDatasetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_dataset_group.DeleteDatasetGroupInput, options: CallOptions) !delete_dataset_group.DeleteDatasetGroupOutput {
        return delete_dataset_group.execute(self, allocator, input, options);
    }

    /// Deletes the event tracker. Does not delete the dataset from
    /// the dataset group. For more
    /// information on event trackers, see
    /// [CreateEventTracker](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateEventTracker.html).
    pub fn deleteEventTracker(self: *Self, allocator: std.mem.Allocator, input: delete_event_tracker.DeleteEventTrackerInput, options: CallOptions) !delete_event_tracker.DeleteEventTrackerOutput {
        return delete_event_tracker.execute(self, allocator, input, options);
    }

    /// Deletes a filter.
    pub fn deleteFilter(self: *Self, allocator: std.mem.Allocator, input: delete_filter.DeleteFilterInput, options: CallOptions) !delete_filter.DeleteFilterOutput {
        return delete_filter.execute(self, allocator, input, options);
    }

    /// Deletes a metric attribution.
    pub fn deleteMetricAttribution(self: *Self, allocator: std.mem.Allocator, input: delete_metric_attribution.DeleteMetricAttributionInput, options: CallOptions) !delete_metric_attribution.DeleteMetricAttributionOutput {
        return delete_metric_attribution.execute(self, allocator, input, options);
    }

    /// Deactivates and removes a recommender. A deleted recommender can no longer
    /// be specified in a
    /// [GetRecommendations](https://docs.aws.amazon.com/personalize/latest/dg/API_RS_GetRecommendations.html)
    /// request.
    pub fn deleteRecommender(self: *Self, allocator: std.mem.Allocator, input: delete_recommender.DeleteRecommenderInput, options: CallOptions) !delete_recommender.DeleteRecommenderOutput {
        return delete_recommender.execute(self, allocator, input, options);
    }

    /// Deletes a schema. Before deleting a schema, you must delete all
    /// datasets referencing the schema. For more information on schemas, see
    /// [CreateSchema](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSchema.html).
    pub fn deleteSchema(self: *Self, allocator: std.mem.Allocator, input: delete_schema.DeleteSchemaInput, options: CallOptions) !delete_schema.DeleteSchemaOutput {
        return delete_schema.execute(self, allocator, input, options);
    }

    /// Deletes all versions of a solution and the `Solution` object itself.
    /// Before deleting a solution, you must delete all campaigns based on
    /// the solution. To determine what campaigns are using the solution, call
    /// [ListCampaigns](https://docs.aws.amazon.com/personalize/latest/dg/API_ListCampaigns.html) and supply the Amazon Resource Name (ARN) of the solution.
    /// You can't delete a solution if an associated `SolutionVersion` is in the
    /// CREATE PENDING or IN PROGRESS state.
    /// For more information on solutions, see
    /// [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html).
    pub fn deleteSolution(self: *Self, allocator: std.mem.Allocator, input: delete_solution.DeleteSolutionInput, options: CallOptions) !delete_solution.DeleteSolutionOutput {
        return delete_solution.execute(self, allocator, input, options);
    }

    /// Describes the given algorithm.
    pub fn describeAlgorithm(self: *Self, allocator: std.mem.Allocator, input: describe_algorithm.DescribeAlgorithmInput, options: CallOptions) !describe_algorithm.DescribeAlgorithmOutput {
        return describe_algorithm.execute(self, allocator, input, options);
    }

    /// Gets the properties of a batch inference job including name, Amazon Resource
    /// Name (ARN),
    /// status, input and output configurations, and the ARN of the solution version
    /// used to generate
    /// the recommendations.
    pub fn describeBatchInferenceJob(self: *Self, allocator: std.mem.Allocator, input: describe_batch_inference_job.DescribeBatchInferenceJobInput, options: CallOptions) !describe_batch_inference_job.DescribeBatchInferenceJobOutput {
        return describe_batch_inference_job.execute(self, allocator, input, options);
    }

    /// Gets the properties of a batch segment job including name, Amazon Resource
    /// Name (ARN),
    /// status, input and output configurations, and the ARN of the solution version
    /// used to generate
    /// segments.
    pub fn describeBatchSegmentJob(self: *Self, allocator: std.mem.Allocator, input: describe_batch_segment_job.DescribeBatchSegmentJobInput, options: CallOptions) !describe_batch_segment_job.DescribeBatchSegmentJobOutput {
        return describe_batch_segment_job.execute(self, allocator, input, options);
    }

    /// Describes the given campaign, including its status.
    ///
    /// A campaign can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    ///
    /// When the `status` is `CREATE FAILED`, the response includes the
    /// `failureReason` key, which describes why.
    ///
    /// For more information on campaigns, see
    /// [CreateCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateCampaign.html).
    pub fn describeCampaign(self: *Self, allocator: std.mem.Allocator, input: describe_campaign.DescribeCampaignInput, options: CallOptions) !describe_campaign.DescribeCampaignOutput {
        return describe_campaign.execute(self, allocator, input, options);
    }

    /// Describes the data deletion job created by
    /// [CreateDataDeletionJob](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDataDeletionJob.html), including the job status.
    pub fn describeDataDeletionJob(self: *Self, allocator: std.mem.Allocator, input: describe_data_deletion_job.DescribeDataDeletionJobInput, options: CallOptions) !describe_data_deletion_job.DescribeDataDeletionJobOutput {
        return describe_data_deletion_job.execute(self, allocator, input, options);
    }

    /// Describes the given dataset. For more information on datasets, see
    /// [CreateDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDataset.html).
    pub fn describeDataset(self: *Self, allocator: std.mem.Allocator, input: describe_dataset.DescribeDatasetInput, options: CallOptions) !describe_dataset.DescribeDatasetOutput {
        return describe_dataset.execute(self, allocator, input, options);
    }

    /// Describes the dataset export job created by
    /// [CreateDatasetExportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetExportJob.html), including the export job status.
    pub fn describeDatasetExportJob(self: *Self, allocator: std.mem.Allocator, input: describe_dataset_export_job.DescribeDatasetExportJobInput, options: CallOptions) !describe_dataset_export_job.DescribeDatasetExportJobOutput {
        return describe_dataset_export_job.execute(self, allocator, input, options);
    }

    /// Describes the given dataset group. For more information on dataset
    /// groups, see
    /// [CreateDatasetGroup](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetGroup.html).
    pub fn describeDatasetGroup(self: *Self, allocator: std.mem.Allocator, input: describe_dataset_group.DescribeDatasetGroupInput, options: CallOptions) !describe_dataset_group.DescribeDatasetGroupOutput {
        return describe_dataset_group.execute(self, allocator, input, options);
    }

    /// Describes the dataset import job created by
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetImportJob.html), including the import job status.
    pub fn describeDatasetImportJob(self: *Self, allocator: std.mem.Allocator, input: describe_dataset_import_job.DescribeDatasetImportJobInput, options: CallOptions) !describe_dataset_import_job.DescribeDatasetImportJobOutput {
        return describe_dataset_import_job.execute(self, allocator, input, options);
    }

    /// Describes an event tracker. The response includes the `trackingId` and
    /// `status` of the event tracker.
    /// For more information on event trackers, see
    /// [CreateEventTracker](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateEventTracker.html).
    pub fn describeEventTracker(self: *Self, allocator: std.mem.Allocator, input: describe_event_tracker.DescribeEventTrackerInput, options: CallOptions) !describe_event_tracker.DescribeEventTrackerOutput {
        return describe_event_tracker.execute(self, allocator, input, options);
    }

    /// Describes the given feature transformation.
    pub fn describeFeatureTransformation(self: *Self, allocator: std.mem.Allocator, input: describe_feature_transformation.DescribeFeatureTransformationInput, options: CallOptions) !describe_feature_transformation.DescribeFeatureTransformationOutput {
        return describe_feature_transformation.execute(self, allocator, input, options);
    }

    /// Describes a filter's properties.
    pub fn describeFilter(self: *Self, allocator: std.mem.Allocator, input: describe_filter.DescribeFilterInput, options: CallOptions) !describe_filter.DescribeFilterOutput {
        return describe_filter.execute(self, allocator, input, options);
    }

    /// Describes a metric attribution.
    pub fn describeMetricAttribution(self: *Self, allocator: std.mem.Allocator, input: describe_metric_attribution.DescribeMetricAttributionInput, options: CallOptions) !describe_metric_attribution.DescribeMetricAttributionOutput {
        return describe_metric_attribution.execute(self, allocator, input, options);
    }

    /// Describes a recipe.
    ///
    /// A recipe contains three items:
    ///
    /// * An algorithm that trains a model.
    ///
    /// * Hyperparameters that govern the training.
    ///
    /// * Feature transformation information for modifying the input data before
    ///   training.
    ///
    /// Amazon Personalize provides a set of predefined recipes. You specify a
    /// recipe when you create a
    /// solution with the
    /// [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html) API.
    /// `CreateSolution` trains a model by using the algorithm
    /// in the specified recipe and a training dataset. The solution, when deployed
    /// as a campaign,
    /// can provide recommendations using the
    /// [GetRecommendations](https://docs.aws.amazon.com/personalize/latest/dg/API_RS_GetRecommendations.html) API.
    pub fn describeRecipe(self: *Self, allocator: std.mem.Allocator, input: describe_recipe.DescribeRecipeInput, options: CallOptions) !describe_recipe.DescribeRecipeOutput {
        return describe_recipe.execute(self, allocator, input, options);
    }

    /// Describes the given recommender, including its status.
    ///
    /// A recommender can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * STOP PENDING > STOP IN_PROGRESS > INACTIVE > START PENDING > START
    ///   IN_PROGRESS > ACTIVE
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    ///
    /// When the `status` is `CREATE FAILED`, the response includes the
    /// `failureReason` key, which describes why.
    ///
    /// The `modelMetrics` key is null when
    /// the recommender is being created or deleted.
    ///
    /// For more information on recommenders, see
    /// [CreateRecommender](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateRecommender.html).
    pub fn describeRecommender(self: *Self, allocator: std.mem.Allocator, input: describe_recommender.DescribeRecommenderInput, options: CallOptions) !describe_recommender.DescribeRecommenderOutput {
        return describe_recommender.execute(self, allocator, input, options);
    }

    /// Describes a schema. For more information on schemas, see
    /// [CreateSchema](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSchema.html).
    pub fn describeSchema(self: *Self, allocator: std.mem.Allocator, input: describe_schema.DescribeSchemaInput, options: CallOptions) !describe_schema.DescribeSchemaOutput {
        return describe_schema.execute(self, allocator, input, options);
    }

    /// Describes a solution.
    /// For more information on solutions, see
    /// [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html).
    pub fn describeSolution(self: *Self, allocator: std.mem.Allocator, input: describe_solution.DescribeSolutionInput, options: CallOptions) !describe_solution.DescribeSolutionOutput {
        return describe_solution.execute(self, allocator, input, options);
    }

    /// Describes a specific version of a solution. For more information on
    /// solutions, see
    /// [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html)
    pub fn describeSolutionVersion(self: *Self, allocator: std.mem.Allocator, input: describe_solution_version.DescribeSolutionVersionInput, options: CallOptions) !describe_solution_version.DescribeSolutionVersionOutput {
        return describe_solution_version.execute(self, allocator, input, options);
    }

    /// Gets the metrics for the specified solution version.
    pub fn getSolutionMetrics(self: *Self, allocator: std.mem.Allocator, input: get_solution_metrics.GetSolutionMetricsInput, options: CallOptions) !get_solution_metrics.GetSolutionMetricsOutput {
        return get_solution_metrics.execute(self, allocator, input, options);
    }

    /// Gets a list of the batch inference jobs that have been performed off of a
    /// solution
    /// version.
    pub fn listBatchInferenceJobs(self: *Self, allocator: std.mem.Allocator, input: list_batch_inference_jobs.ListBatchInferenceJobsInput, options: CallOptions) !list_batch_inference_jobs.ListBatchInferenceJobsOutput {
        return list_batch_inference_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of the batch segment jobs that have been performed off of a
    /// solution
    /// version that you specify.
    pub fn listBatchSegmentJobs(self: *Self, allocator: std.mem.Allocator, input: list_batch_segment_jobs.ListBatchSegmentJobsInput, options: CallOptions) !list_batch_segment_jobs.ListBatchSegmentJobsOutput {
        return list_batch_segment_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of campaigns that use the given solution.
    /// When a solution is not specified, all the campaigns associated with the
    /// account are listed.
    /// The response provides the properties for each campaign, including the Amazon
    /// Resource Name (ARN).
    /// For more information on campaigns, see
    /// [CreateCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateCampaign.html).
    pub fn listCampaigns(self: *Self, allocator: std.mem.Allocator, input: list_campaigns.ListCampaignsInput, options: CallOptions) !list_campaigns.ListCampaignsOutput {
        return list_campaigns.execute(self, allocator, input, options);
    }

    /// Returns a list of data deletion jobs for a dataset group ordered by creation
    /// time,
    /// with the most recent first.
    /// When
    /// a dataset group is not specified, all the data deletion jobs associated with
    /// the account are listed. The response provides the properties for each
    /// job, including the Amazon Resource Name (ARN). For more
    /// information on data deletion jobs, see [Deleting
    /// users](https://docs.aws.amazon.com/personalize/latest/dg/delete-records.html).
    pub fn listDataDeletionJobs(self: *Self, allocator: std.mem.Allocator, input: list_data_deletion_jobs.ListDataDeletionJobsInput, options: CallOptions) !list_data_deletion_jobs.ListDataDeletionJobsOutput {
        return list_data_deletion_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of dataset export jobs that use the given dataset. When
    /// a dataset is not specified, all the dataset export jobs associated with
    /// the account are listed. The response provides the properties for each
    /// dataset export job, including the Amazon Resource Name (ARN). For more
    /// information on dataset export jobs, see
    /// [CreateDatasetExportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetExportJob.html). For more information on datasets, see
    /// [CreateDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDataset.html).
    pub fn listDatasetExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_dataset_export_jobs.ListDatasetExportJobsInput, options: CallOptions) !list_dataset_export_jobs.ListDatasetExportJobsOutput {
        return list_dataset_export_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of dataset groups. The response provides the properties
    /// for each dataset group, including the Amazon Resource Name (ARN). For more
    /// information on dataset groups, see
    /// [CreateDatasetGroup](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetGroup.html).
    pub fn listDatasetGroups(self: *Self, allocator: std.mem.Allocator, input: list_dataset_groups.ListDatasetGroupsInput, options: CallOptions) !list_dataset_groups.ListDatasetGroupsOutput {
        return list_dataset_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of dataset import jobs that use the given dataset. When
    /// a dataset is not specified, all the dataset import jobs associated with
    /// the account are listed. The response provides the properties for each
    /// dataset import job, including the Amazon Resource Name (ARN). For more
    /// information on dataset import jobs, see
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetImportJob.html). For more information on datasets, see
    /// [CreateDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDataset.html).
    pub fn listDatasetImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_dataset_import_jobs.ListDatasetImportJobsInput, options: CallOptions) !list_dataset_import_jobs.ListDatasetImportJobsOutput {
        return list_dataset_import_jobs.execute(self, allocator, input, options);
    }

    /// Returns the list of datasets contained in the given dataset group. The
    /// response provides the properties for each dataset, including the Amazon
    /// Resource Name (ARN). For more information on datasets, see
    /// [CreateDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDataset.html).
    pub fn listDatasets(self: *Self, allocator: std.mem.Allocator, input: list_datasets.ListDatasetsInput, options: CallOptions) !list_datasets.ListDatasetsOutput {
        return list_datasets.execute(self, allocator, input, options);
    }

    /// Returns the list of event trackers associated with the account.
    /// The response provides the properties for each event tracker, including the
    /// Amazon Resource
    /// Name (ARN) and tracking ID. For more
    /// information on event trackers, see
    /// [CreateEventTracker](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateEventTracker.html).
    pub fn listEventTrackers(self: *Self, allocator: std.mem.Allocator, input: list_event_trackers.ListEventTrackersInput, options: CallOptions) !list_event_trackers.ListEventTrackersOutput {
        return list_event_trackers.execute(self, allocator, input, options);
    }

    /// Lists all filters that belong to a given dataset group.
    pub fn listFilters(self: *Self, allocator: std.mem.Allocator, input: list_filters.ListFiltersInput, options: CallOptions) !list_filters.ListFiltersOutput {
        return list_filters.execute(self, allocator, input, options);
    }

    /// Lists the metrics for the metric attribution.
    pub fn listMetricAttributionMetrics(self: *Self, allocator: std.mem.Allocator, input: list_metric_attribution_metrics.ListMetricAttributionMetricsInput, options: CallOptions) !list_metric_attribution_metrics.ListMetricAttributionMetricsOutput {
        return list_metric_attribution_metrics.execute(self, allocator, input, options);
    }

    /// Lists metric attributions.
    pub fn listMetricAttributions(self: *Self, allocator: std.mem.Allocator, input: list_metric_attributions.ListMetricAttributionsInput, options: CallOptions) !list_metric_attributions.ListMetricAttributionsOutput {
        return list_metric_attributions.execute(self, allocator, input, options);
    }

    /// Returns a list of available recipes. The response provides the properties
    /// for each recipe, including the recipe's Amazon Resource Name (ARN).
    pub fn listRecipes(self: *Self, allocator: std.mem.Allocator, input: list_recipes.ListRecipesInput, options: CallOptions) !list_recipes.ListRecipesOutput {
        return list_recipes.execute(self, allocator, input, options);
    }

    /// Returns a list of recommenders in a given Domain dataset group.
    /// When a Domain dataset group is not specified, all the recommenders
    /// associated with the account are listed.
    /// The response provides the properties for each recommender, including the
    /// Amazon Resource Name (ARN).
    /// For more information on recommenders, see
    /// [CreateRecommender](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateRecommender.html).
    pub fn listRecommenders(self: *Self, allocator: std.mem.Allocator, input: list_recommenders.ListRecommendersInput, options: CallOptions) !list_recommenders.ListRecommendersOutput {
        return list_recommenders.execute(self, allocator, input, options);
    }

    /// Returns the list of schemas associated with the account. The response
    /// provides the
    /// properties for each schema, including the Amazon Resource Name (ARN).
    /// For more information on schemas, see
    /// [CreateSchema](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSchema.html).
    pub fn listSchemas(self: *Self, allocator: std.mem.Allocator, input: list_schemas.ListSchemasInput, options: CallOptions) !list_schemas.ListSchemasOutput {
        return list_schemas.execute(self, allocator, input, options);
    }

    /// Returns a list of solution versions for the given solution. When a solution
    /// is not
    /// specified, all the solution versions associated with the account are listed.
    /// The response
    /// provides the properties for each solution version, including the Amazon
    /// Resource Name (ARN).
    pub fn listSolutionVersions(self: *Self, allocator: std.mem.Allocator, input: list_solution_versions.ListSolutionVersionsInput, options: CallOptions) !list_solution_versions.ListSolutionVersionsOutput {
        return list_solution_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of solutions in a given dataset group.
    /// When a dataset group is not specified, all the solutions associated with the
    /// account are listed.
    /// The response provides the properties for each solution, including the Amazon
    /// Resource Name (ARN).
    /// For more information on solutions, see
    /// [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html).
    pub fn listSolutions(self: *Self, allocator: std.mem.Allocator, input: list_solutions.ListSolutionsInput, options: CallOptions) !list_solutions.ListSolutionsOutput {
        return list_solutions.execute(self, allocator, input, options);
    }

    /// Get a list of
    /// [tags](https://docs.aws.amazon.com/personalize/latest/dg/tagging-resources.html) attached to a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts a recommender that is INACTIVE. Starting a recommender does not
    /// create any new models, but resumes billing and automatic retraining for the
    /// recommender.
    pub fn startRecommender(self: *Self, allocator: std.mem.Allocator, input: start_recommender.StartRecommenderInput, options: CallOptions) !start_recommender.StartRecommenderOutput {
        return start_recommender.execute(self, allocator, input, options);
    }

    /// Stops a recommender that is ACTIVE. Stopping a recommender halts billing and
    /// automatic retraining for the recommender.
    pub fn stopRecommender(self: *Self, allocator: std.mem.Allocator, input: stop_recommender.StopRecommenderInput, options: CallOptions) !stop_recommender.StopRecommenderOutput {
        return stop_recommender.execute(self, allocator, input, options);
    }

    /// Stops creating a solution version that is in a state of CREATE_PENDING or
    /// CREATE IN_PROGRESS.
    ///
    /// Depending on the current state of the solution version, the solution version
    /// state changes as follows:
    ///
    /// * CREATE_PENDING > CREATE_STOPPED
    ///
    /// or
    ///
    /// * CREATE_IN_PROGRESS > CREATE_STOPPING > CREATE_STOPPED
    ///
    /// You are billed for all of the training completed up
    /// until you stop the solution version creation. You cannot resume creating a
    /// solution version once it has been stopped.
    pub fn stopSolutionVersionCreation(self: *Self, allocator: std.mem.Allocator, input: stop_solution_version_creation.StopSolutionVersionCreationInput, options: CallOptions) !stop_solution_version_creation.StopSolutionVersionCreationOutput {
        return stop_solution_version_creation.execute(self, allocator, input, options);
    }

    /// Add a list of tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags that are attached to a resource. For more
    /// information, see [Removing tags from Amazon Personalize
    /// resources](https://docs.aws.amazon.com/personalize/latest/dg/tags-remove.html).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a campaign to deploy a retrained solution version with an existing
    /// campaign, change your campaign's `minProvisionedTPS`,
    /// or modify your campaign's configuration. For example, you can set
    /// `enableMetadataWithRecommendations` to true for an existing campaign.
    ///
    /// To update a campaign to start automatically using the latest solution
    /// version, specify the following:
    ///
    /// * For the `SolutionVersionArn` parameter, specify the Amazon Resource Name
    ///   (ARN) of your solution in
    /// `SolutionArn/$LATEST` format.
    ///
    /// * In the `campaignConfig`, set `syncWithLatestSolutionVersion` to `true`.
    ///
    /// To update a campaign, the campaign status must be ACTIVE or CREATE FAILED.
    /// Check the campaign status using the
    /// [DescribeCampaign](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeCampaign.html) operation.
    ///
    /// You can still get recommendations from a campaign while an update is in
    /// progress.
    /// The campaign will use the previous solution version and campaign
    /// configuration to generate recommendations until the latest campaign update
    /// status is `Active`.
    ///
    /// For more information about updating a campaign, including code samples, see
    /// [Updating a
    /// campaign](https://docs.aws.amazon.com/personalize/latest/dg/update-campaigns.html).
    /// For more information about campaigns, see [Creating a
    /// campaign](https://docs.aws.amazon.com/personalize/latest/dg/campaigns.html).
    pub fn updateCampaign(self: *Self, allocator: std.mem.Allocator, input: update_campaign.UpdateCampaignInput, options: CallOptions) !update_campaign.UpdateCampaignOutput {
        return update_campaign.execute(self, allocator, input, options);
    }

    /// Update a dataset to replace its schema with a new or existing one. For more
    /// information, see [Replacing a dataset's
    /// schema](https://docs.aws.amazon.com/personalize/latest/dg/updating-dataset-schema.html).
    pub fn updateDataset(self: *Self, allocator: std.mem.Allocator, input: update_dataset.UpdateDatasetInput, options: CallOptions) !update_dataset.UpdateDatasetOutput {
        return update_dataset.execute(self, allocator, input, options);
    }

    /// Updates a metric attribution.
    pub fn updateMetricAttribution(self: *Self, allocator: std.mem.Allocator, input: update_metric_attribution.UpdateMetricAttributionInput, options: CallOptions) !update_metric_attribution.UpdateMetricAttributionOutput {
        return update_metric_attribution.execute(self, allocator, input, options);
    }

    /// Updates the recommender to modify the recommender configuration.
    /// If you update the recommender to modify the columns used in training, Amazon
    /// Personalize automatically starts a full retraining of
    /// the models backing your recommender. While the update completes, you can
    /// still get recommendations from the recommender. The recommender
    /// uses the previous configuration until the update completes.
    /// To track the status of this update,
    /// use the `latestRecommenderUpdate` returned in the
    /// [DescribeRecommender](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeRecommender.html)
    /// operation.
    pub fn updateRecommender(self: *Self, allocator: std.mem.Allocator, input: update_recommender.UpdateRecommenderInput, options: CallOptions) !update_recommender.UpdateRecommenderOutput {
        return update_recommender.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Personalize solution to use a different automatic training
    /// configuration. When you update a solution,
    /// you can change whether the solution uses
    /// automatic training, and you can change the training frequency. For more
    /// information about updating a solution, see
    /// [Updating a
    /// solution](https://docs.aws.amazon.com/personalize/latest/dg/updating-solution.html).
    ///
    /// A solution update can be in one of the
    /// following states:
    ///
    /// CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// To get the status of a solution update, call the
    /// [DescribeSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolution.html) API operation and find the status
    /// in the `latestSolutionUpdate`.
    pub fn updateSolution(self: *Self, allocator: std.mem.Allocator, input: update_solution.UpdateSolutionInput, options: CallOptions) !update_solution.UpdateSolutionOutput {
        return update_solution.execute(self, allocator, input, options);
    }

    pub fn listBatchInferenceJobsPaginator(self: *Self, params: list_batch_inference_jobs.ListBatchInferenceJobsInput) paginator.ListBatchInferenceJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBatchSegmentJobsPaginator(self: *Self, params: list_batch_segment_jobs.ListBatchSegmentJobsInput) paginator.ListBatchSegmentJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCampaignsPaginator(self: *Self, params: list_campaigns.ListCampaignsInput) paginator.ListCampaignsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatasetExportJobsPaginator(self: *Self, params: list_dataset_export_jobs.ListDatasetExportJobsInput) paginator.ListDatasetExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatasetGroupsPaginator(self: *Self, params: list_dataset_groups.ListDatasetGroupsInput) paginator.ListDatasetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatasetImportJobsPaginator(self: *Self, params: list_dataset_import_jobs.ListDatasetImportJobsInput) paginator.ListDatasetImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatasetsPaginator(self: *Self, params: list_datasets.ListDatasetsInput) paginator.ListDatasetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEventTrackersPaginator(self: *Self, params: list_event_trackers.ListEventTrackersInput) paginator.ListEventTrackersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFiltersPaginator(self: *Self, params: list_filters.ListFiltersInput) paginator.ListFiltersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMetricAttributionMetricsPaginator(self: *Self, params: list_metric_attribution_metrics.ListMetricAttributionMetricsInput) paginator.ListMetricAttributionMetricsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMetricAttributionsPaginator(self: *Self, params: list_metric_attributions.ListMetricAttributionsInput) paginator.ListMetricAttributionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecipesPaginator(self: *Self, params: list_recipes.ListRecipesInput) paginator.ListRecipesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecommendersPaginator(self: *Self, params: list_recommenders.ListRecommendersInput) paginator.ListRecommendersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSchemasPaginator(self: *Self, params: list_schemas.ListSchemasInput) paginator.ListSchemasPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSolutionVersionsPaginator(self: *Self, params: list_solution_versions.ListSolutionVersionsInput) paginator.ListSolutionVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSolutionsPaginator(self: *Self, params: list_solutions.ListSolutionsInput) paginator.ListSolutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
