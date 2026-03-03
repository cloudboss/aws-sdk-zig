const aws = @import("aws");
const std = @import("std");

const delete_recommendation_preferences = @import("delete_recommendation_preferences.zig");
const describe_recommendation_export_jobs = @import("describe_recommendation_export_jobs.zig");
const export_auto_scaling_group_recommendations = @import("export_auto_scaling_group_recommendations.zig");
const export_ebs_volume_recommendations = @import("export_ebs_volume_recommendations.zig");
const export_ec2_instance_recommendations = @import("export_ec2_instance_recommendations.zig");
const export_ecs_service_recommendations = @import("export_ecs_service_recommendations.zig");
const export_idle_recommendations = @import("export_idle_recommendations.zig");
const export_lambda_function_recommendations = @import("export_lambda_function_recommendations.zig");
const export_license_recommendations = @import("export_license_recommendations.zig");
const export_rds_database_recommendations = @import("export_rds_database_recommendations.zig");
const get_auto_scaling_group_recommendations = @import("get_auto_scaling_group_recommendations.zig");
const get_ebs_volume_recommendations = @import("get_ebs_volume_recommendations.zig");
const get_ec2_instance_recommendations = @import("get_ec2_instance_recommendations.zig");
const get_ec2_recommendation_projected_metrics = @import("get_ec2_recommendation_projected_metrics.zig");
const get_ecs_service_recommendation_projected_metrics = @import("get_ecs_service_recommendation_projected_metrics.zig");
const get_ecs_service_recommendations = @import("get_ecs_service_recommendations.zig");
const get_effective_recommendation_preferences = @import("get_effective_recommendation_preferences.zig");
const get_enrollment_status = @import("get_enrollment_status.zig");
const get_enrollment_statuses_for_organization = @import("get_enrollment_statuses_for_organization.zig");
const get_idle_recommendations = @import("get_idle_recommendations.zig");
const get_lambda_function_recommendations = @import("get_lambda_function_recommendations.zig");
const get_license_recommendations = @import("get_license_recommendations.zig");
const get_rds_database_recommendation_projected_metrics = @import("get_rds_database_recommendation_projected_metrics.zig");
const get_rds_database_recommendations = @import("get_rds_database_recommendations.zig");
const get_recommendation_preferences = @import("get_recommendation_preferences.zig");
const get_recommendation_summaries = @import("get_recommendation_summaries.zig");
const put_recommendation_preferences = @import("put_recommendation_preferences.zig");
const update_enrollment_status = @import("update_enrollment_status.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Compute Optimizer";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Deletes a recommendation preference, such as enhanced infrastructure
    /// metrics.
    ///
    /// For more information, see [Activating
    /// enhanced infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
    /// Guide*.
    pub fn deleteRecommendationPreferences(self: *Self, allocator: std.mem.Allocator, input: delete_recommendation_preferences.DeleteRecommendationPreferencesInput, options: delete_recommendation_preferences.Options) !delete_recommendation_preferences.DeleteRecommendationPreferencesOutput {
        return delete_recommendation_preferences.execute(self, allocator, input, options);
    }

    /// Describes recommendation export jobs created in the last seven days.
    ///
    /// Use the ExportAutoScalingGroupRecommendations or
    /// ExportEC2InstanceRecommendations actions to request an export of your
    /// recommendations. Then use the DescribeRecommendationExportJobs action
    /// to view your export jobs.
    pub fn describeRecommendationExportJobs(self: *Self, allocator: std.mem.Allocator, input: describe_recommendation_export_jobs.DescribeRecommendationExportJobsInput, options: describe_recommendation_export_jobs.Options) !describe_recommendation_export_jobs.DescribeRecommendationExportJobsOutput {
        return describe_recommendation_export_jobs.execute(self, allocator, input, options);
    }

    /// Exports optimization recommendations for Amazon EC2 Auto Scaling groups.
    ///
    /// Recommendations are exported in a comma-separated values (.csv) file, and
    /// its metadata
    /// in a JavaScript Object Notation (JSON) (.json) file, to an existing Amazon
    /// Simple Storage Service (Amazon S3) bucket that you specify. For more
    /// information, see [Exporting
    /// Recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html) in the *Compute Optimizer User
    /// Guide*.
    ///
    /// You can have only one Amazon EC2 Auto Scaling group export job in progress
    /// per Amazon Web Services Region.
    pub fn exportAutoScalingGroupRecommendations(self: *Self, allocator: std.mem.Allocator, input: export_auto_scaling_group_recommendations.ExportAutoScalingGroupRecommendationsInput, options: export_auto_scaling_group_recommendations.Options) !export_auto_scaling_group_recommendations.ExportAutoScalingGroupRecommendationsOutput {
        return export_auto_scaling_group_recommendations.execute(self, allocator, input, options);
    }

    /// Exports optimization recommendations for Amazon EBS volumes.
    ///
    /// Recommendations are exported in a comma-separated values (.csv) file, and
    /// its metadata
    /// in a JavaScript Object Notation (JSON) (.json) file, to an existing Amazon
    /// Simple Storage Service (Amazon S3) bucket that you specify. For more
    /// information, see [Exporting
    /// Recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html) in the *Compute Optimizer User
    /// Guide*.
    ///
    /// You can have only one Amazon EBS volume export job in progress per Amazon
    /// Web Services Region.
    pub fn exportEbsVolumeRecommendations(self: *Self, allocator: std.mem.Allocator, input: export_ebs_volume_recommendations.ExportEBSVolumeRecommendationsInput, options: export_ebs_volume_recommendations.Options) !export_ebs_volume_recommendations.ExportEBSVolumeRecommendationsOutput {
        return export_ebs_volume_recommendations.execute(self, allocator, input, options);
    }

    /// Exports optimization recommendations for Amazon EC2 instances.
    ///
    /// Recommendations are exported in a comma-separated values (.csv) file, and
    /// its metadata
    /// in a JavaScript Object Notation (JSON) (.json) file, to an existing Amazon
    /// Simple Storage Service (Amazon S3) bucket that you specify. For more
    /// information, see [Exporting
    /// Recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html) in the *Compute Optimizer User
    /// Guide*.
    ///
    /// You can have only one Amazon EC2 instance export job in progress per Amazon
    /// Web Services Region.
    pub fn exportEc2InstanceRecommendations(self: *Self, allocator: std.mem.Allocator, input: export_ec2_instance_recommendations.ExportEC2InstanceRecommendationsInput, options: export_ec2_instance_recommendations.Options) !export_ec2_instance_recommendations.ExportEC2InstanceRecommendationsOutput {
        return export_ec2_instance_recommendations.execute(self, allocator, input, options);
    }

    /// Exports optimization recommendations for Amazon ECS services on Fargate.
    ///
    /// Recommendations are exported in a CSV file, and its metadata
    /// in a JSON file, to an existing Amazon Simple Storage Service (Amazon S3)
    /// bucket that you specify. For more information, see [Exporting
    /// Recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html) in the *Compute Optimizer User
    /// Guide*.
    ///
    /// You can only have one Amazon ECS service export job in progress per Amazon
    /// Web Services Region.
    pub fn exportEcsServiceRecommendations(self: *Self, allocator: std.mem.Allocator, input: export_ecs_service_recommendations.ExportECSServiceRecommendationsInput, options: export_ecs_service_recommendations.Options) !export_ecs_service_recommendations.ExportECSServiceRecommendationsOutput {
        return export_ecs_service_recommendations.execute(self, allocator, input, options);
    }

    /// Export optimization recommendations for your idle resources.
    ///
    /// Recommendations are exported in a comma-separated values (CSV) file, and its
    /// metadata
    /// in a JavaScript Object Notation (JSON) file, to an existing Amazon Simple
    /// Storage Service (Amazon S3) bucket that you specify. For more information,
    /// see [Exporting
    /// Recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html) in the *Compute Optimizer User
    /// Guide*.
    ///
    /// You can have only one idle resource export job in progress per Amazon Web
    /// Services Region.
    pub fn exportIdleRecommendations(self: *Self, allocator: std.mem.Allocator, input: export_idle_recommendations.ExportIdleRecommendationsInput, options: export_idle_recommendations.Options) !export_idle_recommendations.ExportIdleRecommendationsOutput {
        return export_idle_recommendations.execute(self, allocator, input, options);
    }

    /// Exports optimization recommendations for Lambda functions.
    ///
    /// Recommendations are exported in a comma-separated values (.csv) file, and
    /// its metadata
    /// in a JavaScript Object Notation (JSON) (.json) file, to an existing Amazon
    /// Simple Storage Service (Amazon S3) bucket that you specify. For more
    /// information, see [Exporting
    /// Recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html) in the *Compute Optimizer User
    /// Guide*.
    ///
    /// You can have only one Lambda function export job in progress per Amazon Web
    /// Services Region.
    pub fn exportLambdaFunctionRecommendations(self: *Self, allocator: std.mem.Allocator, input: export_lambda_function_recommendations.ExportLambdaFunctionRecommendationsInput, options: export_lambda_function_recommendations.Options) !export_lambda_function_recommendations.ExportLambdaFunctionRecommendationsOutput {
        return export_lambda_function_recommendations.execute(self, allocator, input, options);
    }

    /// Export optimization recommendations for your licenses.
    ///
    /// Recommendations are exported in a comma-separated values (CSV) file, and its
    /// metadata
    /// in a JavaScript Object Notation (JSON) file, to an existing Amazon Simple
    /// Storage Service (Amazon S3) bucket that you specify. For more information,
    /// see [Exporting
    /// Recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html) in the *Compute Optimizer User
    /// Guide*.
    ///
    /// You can have only one license export job in progress per Amazon Web Services
    /// Region.
    pub fn exportLicenseRecommendations(self: *Self, allocator: std.mem.Allocator, input: export_license_recommendations.ExportLicenseRecommendationsInput, options: export_license_recommendations.Options) !export_license_recommendations.ExportLicenseRecommendationsOutput {
        return export_license_recommendations.execute(self, allocator, input, options);
    }

    /// Export optimization recommendations for your Amazon Aurora and Amazon
    /// Relational Database Service (Amazon RDS) databases.
    ///
    /// Recommendations are exported in a comma-separated values (CSV) file, and its
    /// metadata
    /// in a JavaScript Object Notation (JSON) file, to an existing Amazon Simple
    /// Storage Service (Amazon S3) bucket that you specify. For more information,
    /// see [Exporting
    /// Recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html) in the *Compute Optimizer User
    /// Guide*.
    ///
    /// You can have only one Amazon Aurora or RDS export job in progress per Amazon
    /// Web Services Region.
    pub fn exportRdsDatabaseRecommendations(self: *Self, allocator: std.mem.Allocator, input: export_rds_database_recommendations.ExportRDSDatabaseRecommendationsInput, options: export_rds_database_recommendations.Options) !export_rds_database_recommendations.ExportRDSDatabaseRecommendationsOutput {
        return export_rds_database_recommendations.execute(self, allocator, input, options);
    }

    /// Returns Amazon EC2 Auto Scaling group recommendations.
    ///
    /// Compute Optimizer generates recommendations for Amazon EC2 Auto Scaling
    /// groups that
    /// meet a specific set of requirements. For more information, see the
    /// [Supported
    /// resources and
    /// requirements](https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html) in the *Compute Optimizer User
    /// Guide*.
    pub fn getAutoScalingGroupRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_auto_scaling_group_recommendations.GetAutoScalingGroupRecommendationsInput, options: get_auto_scaling_group_recommendations.Options) !get_auto_scaling_group_recommendations.GetAutoScalingGroupRecommendationsOutput {
        return get_auto_scaling_group_recommendations.execute(self, allocator, input, options);
    }

    /// Returns Amazon Elastic Block Store (Amazon EBS) volume recommendations.
    ///
    /// Compute Optimizer generates recommendations for Amazon EBS volumes that
    /// meet a specific set of requirements. For more information, see the
    /// [Supported
    /// resources and
    /// requirements](https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html) in the *Compute Optimizer User
    /// Guide*.
    pub fn getEbsVolumeRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_ebs_volume_recommendations.GetEBSVolumeRecommendationsInput, options: get_ebs_volume_recommendations.Options) !get_ebs_volume_recommendations.GetEBSVolumeRecommendationsOutput {
        return get_ebs_volume_recommendations.execute(self, allocator, input, options);
    }

    /// Returns Amazon EC2 instance recommendations.
    ///
    /// Compute Optimizer generates recommendations for Amazon Elastic Compute Cloud
    /// (Amazon EC2) instances that meet a specific set of requirements. For more
    /// information, see the [Supported resources and
    /// requirements](https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html) in the *Compute Optimizer User
    /// Guide*.
    pub fn getEc2InstanceRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_ec2_instance_recommendations.GetEC2InstanceRecommendationsInput, options: get_ec2_instance_recommendations.Options) !get_ec2_instance_recommendations.GetEC2InstanceRecommendationsOutput {
        return get_ec2_instance_recommendations.execute(self, allocator, input, options);
    }

    /// Returns the projected utilization metrics of Amazon EC2 instance
    /// recommendations.
    ///
    /// The `Cpu` and `Memory` metrics are the only projected
    /// utilization metrics returned when you run this action. Additionally, the
    /// `Memory` metric is returned only for resources that have the unified
    /// CloudWatch agent installed on them. For more information, see [Enabling
    /// Memory Utilization with the CloudWatch
    /// Agent](https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent).
    pub fn getEc2RecommendationProjectedMetrics(self: *Self, allocator: std.mem.Allocator, input: get_ec2_recommendation_projected_metrics.GetEC2RecommendationProjectedMetricsInput, options: get_ec2_recommendation_projected_metrics.Options) !get_ec2_recommendation_projected_metrics.GetEC2RecommendationProjectedMetricsOutput {
        return get_ec2_recommendation_projected_metrics.execute(self, allocator, input, options);
    }

    /// Returns the projected metrics of Amazon ECS service recommendations.
    pub fn getEcsServiceRecommendationProjectedMetrics(self: *Self, allocator: std.mem.Allocator, input: get_ecs_service_recommendation_projected_metrics.GetECSServiceRecommendationProjectedMetricsInput, options: get_ecs_service_recommendation_projected_metrics.Options) !get_ecs_service_recommendation_projected_metrics.GetECSServiceRecommendationProjectedMetricsOutput {
        return get_ecs_service_recommendation_projected_metrics.execute(self, allocator, input, options);
    }

    /// Returns Amazon ECS service recommendations.
    ///
    /// Compute Optimizer generates recommendations for Amazon ECS services on
    /// Fargate that meet a specific set of requirements. For more
    /// information, see the [Supported resources and
    /// requirements](https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html) in the *Compute Optimizer User
    /// Guide*.
    pub fn getEcsServiceRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_ecs_service_recommendations.GetECSServiceRecommendationsInput, options: get_ecs_service_recommendations.Options) !get_ecs_service_recommendations.GetECSServiceRecommendationsOutput {
        return get_ecs_service_recommendations.execute(self, allocator, input, options);
    }

    /// Returns the recommendation preferences that are in effect for a given
    /// resource, such
    /// as enhanced infrastructure metrics. Considers all applicable preferences
    /// that you might
    /// have set at the resource, account, and organization level.
    ///
    /// When you create a recommendation preference, you can set its status to
    /// `Active` or `Inactive`. Use this action to view the
    /// recommendation preferences that are in effect, or `Active`.
    pub fn getEffectiveRecommendationPreferences(self: *Self, allocator: std.mem.Allocator, input: get_effective_recommendation_preferences.GetEffectiveRecommendationPreferencesInput, options: get_effective_recommendation_preferences.Options) !get_effective_recommendation_preferences.GetEffectiveRecommendationPreferencesOutput {
        return get_effective_recommendation_preferences.execute(self, allocator, input, options);
    }

    /// Returns the enrollment (opt in) status of an account to the Compute
    /// Optimizer
    /// service.
    ///
    /// If the account is the management account of an organization, this action
    /// also confirms
    /// the enrollment status of member accounts of the organization. Use the
    /// GetEnrollmentStatusesForOrganization action to get detailed information
    /// about the enrollment status of member accounts of an organization.
    pub fn getEnrollmentStatus(self: *Self, allocator: std.mem.Allocator, input: get_enrollment_status.GetEnrollmentStatusInput, options: get_enrollment_status.Options) !get_enrollment_status.GetEnrollmentStatusOutput {
        return get_enrollment_status.execute(self, allocator, input, options);
    }

    /// Returns the Compute Optimizer enrollment (opt-in) status of organization
    /// member
    /// accounts, if your account is an organization management account.
    ///
    /// To get the enrollment status of standalone accounts, use the
    /// GetEnrollmentStatus action.
    pub fn getEnrollmentStatusesForOrganization(self: *Self, allocator: std.mem.Allocator, input: get_enrollment_statuses_for_organization.GetEnrollmentStatusesForOrganizationInput, options: get_enrollment_statuses_for_organization.Options) !get_enrollment_statuses_for_organization.GetEnrollmentStatusesForOrganizationOutput {
        return get_enrollment_statuses_for_organization.execute(self, allocator, input, options);
    }

    /// Returns idle resource recommendations. Compute Optimizer generates
    /// recommendations for
    /// idle resources that meet a specific set of requirements. For more
    /// information, see
    /// [Resource
    /// requirements](https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html) in the
    /// *Compute Optimizer User Guide*
    pub fn getIdleRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_idle_recommendations.GetIdleRecommendationsInput, options: get_idle_recommendations.Options) !get_idle_recommendations.GetIdleRecommendationsOutput {
        return get_idle_recommendations.execute(self, allocator, input, options);
    }

    /// Returns Lambda function recommendations.
    ///
    /// Compute Optimizer generates recommendations for functions that meet a
    /// specific set
    /// of requirements. For more information, see the [Supported resources and
    /// requirements](https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html) in the *Compute Optimizer User
    /// Guide*.
    pub fn getLambdaFunctionRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_lambda_function_recommendations.GetLambdaFunctionRecommendationsInput, options: get_lambda_function_recommendations.Options) !get_lambda_function_recommendations.GetLambdaFunctionRecommendationsOutput {
        return get_lambda_function_recommendations.execute(self, allocator, input, options);
    }

    /// Returns license recommendations for Amazon EC2 instances that run on a
    /// specific license.
    ///
    /// Compute Optimizer generates recommendations for licenses that meet a
    /// specific set of requirements. For more
    /// information, see the [Supported resources and
    /// requirements](https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html) in the *Compute Optimizer User
    /// Guide*.
    pub fn getLicenseRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_license_recommendations.GetLicenseRecommendationsInput, options: get_license_recommendations.Options) !get_license_recommendations.GetLicenseRecommendationsOutput {
        return get_license_recommendations.execute(self, allocator, input, options);
    }

    /// Returns the projected metrics of Aurora and RDS database recommendations.
    pub fn getRdsDatabaseRecommendationProjectedMetrics(self: *Self, allocator: std.mem.Allocator, input: get_rds_database_recommendation_projected_metrics.GetRDSDatabaseRecommendationProjectedMetricsInput, options: get_rds_database_recommendation_projected_metrics.Options) !get_rds_database_recommendation_projected_metrics.GetRDSDatabaseRecommendationProjectedMetricsOutput {
        return get_rds_database_recommendation_projected_metrics.execute(self, allocator, input, options);
    }

    /// Returns Amazon Aurora and RDS database recommendations.
    ///
    /// Compute Optimizer generates recommendations for Amazon Aurora and RDS
    /// databases that
    /// meet a specific set of requirements. For more
    /// information, see the [Supported resources and
    /// requirements](https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html) in the *Compute Optimizer User
    /// Guide*.
    pub fn getRdsDatabaseRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_rds_database_recommendations.GetRDSDatabaseRecommendationsInput, options: get_rds_database_recommendations.Options) !get_rds_database_recommendations.GetRDSDatabaseRecommendationsOutput {
        return get_rds_database_recommendations.execute(self, allocator, input, options);
    }

    /// Returns existing recommendation preferences, such as enhanced infrastructure
    /// metrics.
    ///
    /// Use the `scope` parameter to specify which preferences to return. You can
    /// specify to return preferences for an organization, a specific account ID, or
    /// a specific
    /// EC2 instance or Amazon EC2 Auto Scaling group Amazon Resource Name (ARN).
    ///
    /// For more information, see [Activating
    /// enhanced infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
    /// Guide*.
    pub fn getRecommendationPreferences(self: *Self, allocator: std.mem.Allocator, input: get_recommendation_preferences.GetRecommendationPreferencesInput, options: get_recommendation_preferences.Options) !get_recommendation_preferences.GetRecommendationPreferencesOutput {
        return get_recommendation_preferences.execute(self, allocator, input, options);
    }

    /// Returns the optimization findings for an account.
    ///
    /// It returns the number of:
    ///
    /// * Amazon EC2 instances in an account that are
    /// `Underprovisioned`, `Overprovisioned`, or
    /// `Optimized`.
    ///
    /// * EC2Amazon EC2 Auto Scaling groups in an account that are `NotOptimized`,
    ///   or
    /// `Optimized`.
    ///
    /// * Amazon EBS volumes in an account that are `NotOptimized`,
    /// or `Optimized`.
    ///
    /// * Lambda functions in an account that are `NotOptimized`,
    /// or `Optimized`.
    ///
    /// * Amazon ECS services in an account that are `Underprovisioned`,
    /// `Overprovisioned`, or `Optimized`.
    ///
    /// * Commercial software licenses in an account that are `InsufficientMetrics`,
    /// `NotOptimized` or `Optimized`.
    ///
    /// * Amazon Aurora and Amazon RDS databases in an account that are
    ///   `Underprovisioned`,
    /// `Overprovisioned`, `Optimized`, or `NotOptimized`.
    pub fn getRecommendationSummaries(self: *Self, allocator: std.mem.Allocator, input: get_recommendation_summaries.GetRecommendationSummariesInput, options: get_recommendation_summaries.Options) !get_recommendation_summaries.GetRecommendationSummariesOutput {
        return get_recommendation_summaries.execute(self, allocator, input, options);
    }

    /// Creates a new recommendation preference or updates an existing
    /// recommendation
    /// preference, such as enhanced infrastructure metrics.
    ///
    /// For more information, see [Activating
    /// enhanced infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
    /// Guide*.
    pub fn putRecommendationPreferences(self: *Self, allocator: std.mem.Allocator, input: put_recommendation_preferences.PutRecommendationPreferencesInput, options: put_recommendation_preferences.Options) !put_recommendation_preferences.PutRecommendationPreferencesOutput {
        return put_recommendation_preferences.execute(self, allocator, input, options);
    }

    /// Updates the enrollment (opt in and opt out) status of an account to the
    /// Compute Optimizer service.
    ///
    /// If the account is a management account of an organization, this action can
    /// also be
    /// used to enroll member accounts of the organization.
    ///
    /// You must have the appropriate permissions to opt in to Compute Optimizer, to
    /// view its
    /// recommendations, and to opt out. For more information, see [Controlling
    /// access with Amazon Web Services Identity and Access
    /// Management](https://docs.aws.amazon.com/compute-optimizer/latest/ug/security-iam.html) in the *Compute Optimizer User Guide*.
    ///
    /// When you opt in, Compute Optimizer automatically creates a service-linked
    /// role in your
    /// account to access its data. For more information, see [Using
    /// Service-Linked Roles for Compute
    /// Optimizer](https://docs.aws.amazon.com/compute-optimizer/latest/ug/using-service-linked-roles.html) in the *Compute Optimizer User Guide*.
    pub fn updateEnrollmentStatus(self: *Self, allocator: std.mem.Allocator, input: update_enrollment_status.UpdateEnrollmentStatusInput, options: update_enrollment_status.Options) !update_enrollment_status.UpdateEnrollmentStatusOutput {
        return update_enrollment_status.execute(self, allocator, input, options);
    }

    pub fn describeRecommendationExportJobsPaginator(self: *Self, params: describe_recommendation_export_jobs.DescribeRecommendationExportJobsInput) paginator.DescribeRecommendationExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getEnrollmentStatusesForOrganizationPaginator(self: *Self, params: get_enrollment_statuses_for_organization.GetEnrollmentStatusesForOrganizationInput) paginator.GetEnrollmentStatusesForOrganizationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getLambdaFunctionRecommendationsPaginator(self: *Self, params: get_lambda_function_recommendations.GetLambdaFunctionRecommendationsInput) paginator.GetLambdaFunctionRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getRecommendationPreferencesPaginator(self: *Self, params: get_recommendation_preferences.GetRecommendationPreferencesInput) paginator.GetRecommendationPreferencesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getRecommendationSummariesPaginator(self: *Self, params: get_recommendation_summaries.GetRecommendationSummariesInput) paginator.GetRecommendationSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
