const aws = @import("aws");
const std = @import("std");

const create_auto_predictor = @import("create_auto_predictor.zig");
const create_dataset = @import("create_dataset.zig");
const create_dataset_group = @import("create_dataset_group.zig");
const create_dataset_import_job = @import("create_dataset_import_job.zig");
const create_explainability = @import("create_explainability.zig");
const create_explainability_export = @import("create_explainability_export.zig");
const create_forecast = @import("create_forecast.zig");
const create_forecast_export_job = @import("create_forecast_export_job.zig");
const create_monitor = @import("create_monitor.zig");
const create_predictor = @import("create_predictor.zig");
const create_predictor_backtest_export_job = @import("create_predictor_backtest_export_job.zig");
const create_what_if_analysis = @import("create_what_if_analysis.zig");
const create_what_if_forecast = @import("create_what_if_forecast.zig");
const create_what_if_forecast_export = @import("create_what_if_forecast_export.zig");
const delete_dataset = @import("delete_dataset.zig");
const delete_dataset_group = @import("delete_dataset_group.zig");
const delete_dataset_import_job = @import("delete_dataset_import_job.zig");
const delete_explainability = @import("delete_explainability.zig");
const delete_explainability_export = @import("delete_explainability_export.zig");
const delete_forecast = @import("delete_forecast.zig");
const delete_forecast_export_job = @import("delete_forecast_export_job.zig");
const delete_monitor = @import("delete_monitor.zig");
const delete_predictor = @import("delete_predictor.zig");
const delete_predictor_backtest_export_job = @import("delete_predictor_backtest_export_job.zig");
const delete_resource_tree = @import("delete_resource_tree.zig");
const delete_what_if_analysis = @import("delete_what_if_analysis.zig");
const delete_what_if_forecast = @import("delete_what_if_forecast.zig");
const delete_what_if_forecast_export = @import("delete_what_if_forecast_export.zig");
const describe_auto_predictor = @import("describe_auto_predictor.zig");
const describe_dataset = @import("describe_dataset.zig");
const describe_dataset_group = @import("describe_dataset_group.zig");
const describe_dataset_import_job = @import("describe_dataset_import_job.zig");
const describe_explainability = @import("describe_explainability.zig");
const describe_explainability_export = @import("describe_explainability_export.zig");
const describe_forecast = @import("describe_forecast.zig");
const describe_forecast_export_job = @import("describe_forecast_export_job.zig");
const describe_monitor = @import("describe_monitor.zig");
const describe_predictor = @import("describe_predictor.zig");
const describe_predictor_backtest_export_job = @import("describe_predictor_backtest_export_job.zig");
const describe_what_if_analysis = @import("describe_what_if_analysis.zig");
const describe_what_if_forecast = @import("describe_what_if_forecast.zig");
const describe_what_if_forecast_export = @import("describe_what_if_forecast_export.zig");
const get_accuracy_metrics = @import("get_accuracy_metrics.zig");
const list_dataset_groups = @import("list_dataset_groups.zig");
const list_dataset_import_jobs = @import("list_dataset_import_jobs.zig");
const list_datasets = @import("list_datasets.zig");
const list_explainabilities = @import("list_explainabilities.zig");
const list_explainability_exports = @import("list_explainability_exports.zig");
const list_forecast_export_jobs = @import("list_forecast_export_jobs.zig");
const list_forecasts = @import("list_forecasts.zig");
const list_monitor_evaluations = @import("list_monitor_evaluations.zig");
const list_monitors = @import("list_monitors.zig");
const list_predictor_backtest_export_jobs = @import("list_predictor_backtest_export_jobs.zig");
const list_predictors = @import("list_predictors.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_what_if_analyses = @import("list_what_if_analyses.zig");
const list_what_if_forecast_exports = @import("list_what_if_forecast_exports.zig");
const list_what_if_forecasts = @import("list_what_if_forecasts.zig");
const resume_resource = @import("resume_resource.zig");
const stop_resource = @import("stop_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_dataset_group = @import("update_dataset_group.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "forecast";

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

    /// Creates an Amazon Forecast predictor.
    ///
    /// Amazon Forecast creates predictors with AutoPredictor, which involves
    /// applying the
    /// optimal combination of algorithms to each time series in your datasets. You
    /// can use
    /// CreateAutoPredictor to create new predictors or upgrade/retrain
    /// existing predictors.
    ///
    /// **Creating new predictors**
    ///
    /// The following parameters are required when creating a new predictor:
    ///
    /// * `PredictorName` - A unique name for the predictor.
    ///
    /// * `DatasetGroupArn` - The ARN of the dataset group used to train the
    /// predictor.
    ///
    /// * `ForecastFrequency` - The granularity of your forecasts (hourly,
    /// daily, weekly, etc).
    ///
    /// * `ForecastHorizon` - The number of time-steps that the model
    /// predicts. The forecast horizon is also called the prediction length.
    ///
    /// When creating a new predictor, do not specify a value for
    /// `ReferencePredictorArn`.
    ///
    /// **Upgrading and retraining predictors**
    ///
    /// The following parameters are required when retraining or upgrading a
    /// predictor:
    ///
    /// * `PredictorName` - A unique name for the predictor.
    ///
    /// * `ReferencePredictorArn` - The ARN of the predictor to retrain or
    /// upgrade.
    ///
    /// When upgrading or retraining a predictor, only specify values for the
    /// `ReferencePredictorArn` and `PredictorName`.
    pub fn createAutoPredictor(self: *Self, allocator: std.mem.Allocator, input: create_auto_predictor.CreateAutoPredictorInput, options: create_auto_predictor.Options) !create_auto_predictor.CreateAutoPredictorOutput {
        return create_auto_predictor.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Forecast dataset. The information about the dataset that
    /// you provide helps
    /// Forecast understand how to consume the data for model training. This
    /// includes the
    /// following:
    ///
    /// * *
    /// `DataFrequency`
    /// * - How frequently your historical
    /// time-series data is collected.
    ///
    /// * *
    /// `Domain`
    /// * and
    /// *
    /// `DatasetType`
    /// * - Each dataset has an associated dataset
    /// domain and a type within the domain. Amazon Forecast provides a list of
    /// predefined domains and
    /// types within each domain. For each unique dataset domain and type within the
    /// domain,
    /// Amazon Forecast requires your data to include a minimum set of predefined
    /// fields.
    ///
    /// * *
    /// `Schema`
    /// * - A schema specifies the fields in the dataset,
    /// including the field name and data type.
    ///
    /// After creating a dataset, you import your training data into it and add the
    /// dataset to a
    /// dataset group. You use the dataset group to create a predictor. For more
    /// information, see
    /// [Importing
    /// datasets](https://docs.aws.amazon.com/forecast/latest/dg/howitworks-datasets-groups.html).
    ///
    /// To get a list of all your datasets, use the
    /// [ListDatasets](https://docs.aws.amazon.com/forecast/latest/dg/API_ListDatasets.html) operation.
    ///
    /// For example Forecast datasets, see the [Amazon Forecast Sample GitHub
    /// repository](https://github.com/aws-samples/amazon-forecast-samples).
    ///
    /// The `Status` of a dataset must be `ACTIVE` before you can import
    /// training data. Use the
    /// [DescribeDataset](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDataset.html) operation to get
    /// the status.
    pub fn createDataset(self: *Self, allocator: std.mem.Allocator, input: create_dataset.CreateDatasetInput, options: create_dataset.Options) !create_dataset.CreateDatasetOutput {
        return create_dataset.execute(self, allocator, input, options);
    }

    /// Creates a dataset group, which holds a collection of related datasets. You
    /// can add
    /// datasets to the dataset group when you create the dataset group, or later by
    /// using the
    /// [UpdateDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_UpdateDatasetGroup.html) operation.
    ///
    /// After creating a dataset group and adding datasets, you use the dataset
    /// group when you
    /// create a predictor. For more information, see [Dataset
    /// groups](https://docs.aws.amazon.com/forecast/latest/dg/howitworks-datasets-groups.html).
    ///
    /// To get a list of all your datasets groups, use the
    /// [ListDatasetGroups](https://docs.aws.amazon.com/forecast/latest/dg/API_ListDatasetGroups.html)
    /// operation.
    ///
    /// The `Status` of a dataset group must be `ACTIVE` before you can
    /// use the dataset group to create a predictor. To get the status, use the
    /// [DescribeDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDatasetGroup.html) operation.
    pub fn createDatasetGroup(self: *Self, allocator: std.mem.Allocator, input: create_dataset_group.CreateDatasetGroupInput, options: create_dataset_group.Options) !create_dataset_group.CreateDatasetGroupOutput {
        return create_dataset_group.execute(self, allocator, input, options);
    }

    /// Imports your training data to an Amazon Forecast dataset. You provide the
    /// location of your
    /// training data in an Amazon Simple Storage Service (Amazon S3) bucket and the
    /// Amazon Resource Name (ARN) of the dataset
    /// that you want to import the data to.
    ///
    /// You must specify a
    /// [DataSource](https://docs.aws.amazon.com/forecast/latest/dg/API_DataSource.html) object that includes an
    /// Identity and Access Management (IAM) role that Amazon Forecast can assume to
    /// access the data, as Amazon Forecast makes a copy
    /// of your data and processes it in an internal Amazon Web Services system. For
    /// more information, see [Set up
    /// permissions](https://docs.aws.amazon.com/forecast/latest/dg/aws-forecast-iam-roles.html).
    ///
    /// The training data must be in CSV or Parquet format. The delimiter must be a
    /// comma (,).
    ///
    /// You can specify the path to a specific file, the S3 bucket, or to a folder
    /// in the S3
    /// bucket. For the latter two cases, Amazon Forecast imports all files up to
    /// the limit of 10,000
    /// files.
    ///
    /// Because dataset imports are not aggregated, your most recent dataset import
    /// is the one
    /// that is used when training a predictor or generating a forecast. Make sure
    /// that your most
    /// recent dataset import contains all of the data you want to model off of, and
    /// not just the new
    /// data collected since the previous import.
    ///
    /// To get a list of all your dataset import jobs, filtered by specified
    /// criteria, use the
    /// [ListDatasetImportJobs](https://docs.aws.amazon.com/forecast/latest/dg/API_ListDatasetImportJobs.html) operation.
    pub fn createDatasetImportJob(self: *Self, allocator: std.mem.Allocator, input: create_dataset_import_job.CreateDatasetImportJobInput, options: create_dataset_import_job.Options) !create_dataset_import_job.CreateDatasetImportJobOutput {
        return create_dataset_import_job.execute(self, allocator, input, options);
    }

    /// Explainability is only available for Forecasts and Predictors generated from
    /// an
    /// AutoPredictor (CreateAutoPredictor)
    ///
    /// Creates an Amazon Forecast Explainability.
    ///
    /// Explainability helps you better understand how the attributes in your
    /// datasets impact
    /// forecast. Amazon Forecast uses a metric called Impact scores to quantify the
    /// relative
    /// impact of each attribute and determine whether they increase or decrease
    /// forecast
    /// values.
    ///
    /// To enable Forecast Explainability, your predictor must include at least one
    /// of the
    /// following: related time series, item metadata, or additional datasets like
    /// Holidays and
    /// the Weather Index.
    ///
    /// CreateExplainability accepts either a Predictor ARN or Forecast ARN. To
    /// receive
    /// aggregated Impact scores for all time series and time points in your
    /// datasets, provide a
    /// Predictor ARN. To receive Impact scores for specific time series and time
    /// points,
    /// provide a Forecast ARN.
    ///
    /// **CreateExplainability with a Predictor ARN**
    ///
    /// You can only have one Explainability resource per predictor. If you already
    /// enabled `ExplainPredictor` in CreateAutoPredictor, that
    /// predictor already has an Explainability resource.
    ///
    /// The following parameters are required when providing a Predictor ARN:
    ///
    /// * `ExplainabilityName` - A unique name for the Explainability.
    ///
    /// * `ResourceArn` - The Arn of the predictor.
    ///
    /// * `TimePointGranularity` - Must be set to “ALL”.
    ///
    /// * `TimeSeriesGranularity` - Must be set to “ALL”.
    ///
    /// Do not specify a value for the following parameters:
    ///
    /// * `DataSource` - Only valid when TimeSeriesGranularity is
    /// “SPECIFIC”.
    ///
    /// * `Schema` - Only valid when TimeSeriesGranularity is
    /// “SPECIFIC”.
    ///
    /// * `StartDateTime` - Only valid when TimePointGranularity is
    /// “SPECIFIC”.
    ///
    /// * `EndDateTime` - Only valid when TimePointGranularity is
    /// “SPECIFIC”.
    ///
    /// **CreateExplainability with a Forecast ARN**
    ///
    /// You can specify a maximum of 50 time series and 500 time points.
    ///
    /// The following parameters are required when providing a Predictor ARN:
    ///
    /// * `ExplainabilityName` - A unique name for the Explainability.
    ///
    /// * `ResourceArn` - The Arn of the forecast.
    ///
    /// * `TimePointGranularity` - Either “ALL” or “SPECIFIC”.
    ///
    /// * `TimeSeriesGranularity` - Either “ALL” or “SPECIFIC”.
    ///
    /// If you set TimeSeriesGranularity to “SPECIFIC”, you must also provide the
    /// following:
    ///
    /// * `DataSource` - The S3 location of the CSV file specifying your time
    /// series.
    ///
    /// * `Schema` - The Schema defines the attributes and attribute types
    /// listed in the Data Source.
    ///
    /// If you set TimePointGranularity to “SPECIFIC”, you must also provide the
    /// following:
    ///
    /// * `StartDateTime` - The first timestamp in the range of time
    /// points.
    ///
    /// * `EndDateTime` - The last timestamp in the range of time
    /// points.
    pub fn createExplainability(self: *Self, allocator: std.mem.Allocator, input: create_explainability.CreateExplainabilityInput, options: create_explainability.Options) !create_explainability.CreateExplainabilityOutput {
        return create_explainability.execute(self, allocator, input, options);
    }

    /// Exports an Explainability resource created by the CreateExplainability
    /// operation. Exported files are exported to an Amazon Simple Storage Service
    /// (Amazon
    /// S3) bucket.
    ///
    /// You must specify a DataDestination object that includes an Amazon S3
    /// bucket and an Identity and Access Management (IAM) role that Amazon Forecast
    /// can assume to access the Amazon S3
    /// bucket. For more information, see aws-forecast-iam-roles.
    ///
    /// The `Status` of the export job must be `ACTIVE` before you
    /// can access the export in your Amazon S3 bucket. To get the status, use the
    /// DescribeExplainabilityExport operation.
    pub fn createExplainabilityExport(self: *Self, allocator: std.mem.Allocator, input: create_explainability_export.CreateExplainabilityExportInput, options: create_explainability_export.Options) !create_explainability_export.CreateExplainabilityExportOutput {
        return create_explainability_export.execute(self, allocator, input, options);
    }

    /// Creates a forecast for each item in the `TARGET_TIME_SERIES` dataset that
    /// was
    /// used to train the predictor. This is known as inference. To retrieve the
    /// forecast for a single
    /// item at low latency, use the operation. To
    /// export the complete forecast into your Amazon Simple Storage Service (Amazon
    /// S3) bucket, use the CreateForecastExportJob operation.
    ///
    /// The range of the forecast is determined by the `ForecastHorizon` value,
    /// which
    /// you specify in the CreatePredictor request. When you query a forecast, you
    /// can request a specific date range within the forecast.
    ///
    /// To get a list of all your forecasts, use the ListForecasts
    /// operation.
    ///
    /// The forecasts generated by Amazon Forecast are in the same time zone as the
    /// dataset that was
    /// used to create the predictor.
    ///
    /// For more information, see howitworks-forecast.
    ///
    /// The `Status` of the forecast must be `ACTIVE` before you can query
    /// or export the forecast. Use the DescribeForecast operation to get the
    /// status.
    ///
    /// By default, a forecast includes predictions for every item (`item_id`) in
    /// the dataset group that was used to train the predictor.
    /// However, you can use the `TimeSeriesSelector` object to generate a forecast
    /// on a subset of time series. Forecast creation is skipped for any time series
    /// that you specify that are not in the input dataset. The forecast export file
    /// will not contain these time series or their forecasted values.
    pub fn createForecast(self: *Self, allocator: std.mem.Allocator, input: create_forecast.CreateForecastInput, options: create_forecast.Options) !create_forecast.CreateForecastOutput {
        return create_forecast.execute(self, allocator, input, options);
    }

    /// Exports a forecast created by the CreateForecast operation to your
    /// Amazon Simple Storage Service (Amazon S3) bucket. The forecast file name
    /// will match the following conventions:
    ///
    /// __
    ///
    /// where the component is in Java SimpleDateFormat
    /// (yyyy-MM-ddTHH-mm-ssZ).
    ///
    /// You must specify a DataDestination object that includes an Identity and
    /// Access Management
    /// (IAM) role that Amazon Forecast can assume to access the Amazon S3 bucket.
    /// For more information, see
    /// aws-forecast-iam-roles.
    ///
    /// For more information, see howitworks-forecast.
    ///
    /// To get a list of all your forecast export jobs, use the
    /// ListForecastExportJobs operation.
    ///
    /// The `Status` of the forecast export job must be `ACTIVE` before
    /// you can access the forecast in your Amazon S3 bucket. To get the status, use
    /// the DescribeForecastExportJob operation.
    pub fn createForecastExportJob(self: *Self, allocator: std.mem.Allocator, input: create_forecast_export_job.CreateForecastExportJobInput, options: create_forecast_export_job.Options) !create_forecast_export_job.CreateForecastExportJobOutput {
        return create_forecast_export_job.execute(self, allocator, input, options);
    }

    /// Creates a predictor monitor resource for an existing auto predictor.
    /// Predictor monitoring allows you to see how your predictor's performance
    /// changes over time.
    /// For more information, see [Predictor
    /// Monitoring](https://docs.aws.amazon.com/forecast/latest/dg/predictor-monitoring.html).
    pub fn createMonitor(self: *Self, allocator: std.mem.Allocator, input: create_monitor.CreateMonitorInput, options: create_monitor.Options) !create_monitor.CreateMonitorOutput {
        return create_monitor.execute(self, allocator, input, options);
    }

    /// This operation creates a legacy predictor that does not include all the
    /// predictor
    /// functionalities provided by Amazon Forecast. To create a predictor that is
    /// compatible with all
    /// aspects of Forecast, use CreateAutoPredictor.
    ///
    /// Creates an Amazon Forecast predictor.
    ///
    /// In the request, provide a dataset group and either specify an algorithm or
    /// let Amazon Forecast
    /// choose an algorithm for you using AutoML. If you specify an algorithm, you
    /// also can override
    /// algorithm-specific hyperparameters.
    ///
    /// Amazon Forecast uses the algorithm to train a predictor using the latest
    /// version of the datasets
    /// in the specified dataset group. You can then generate a forecast using the
    /// CreateForecast operation.
    ///
    /// To see the evaluation metrics, use the GetAccuracyMetrics operation.
    ///
    /// You can specify a featurization configuration to fill and aggregate the data
    /// fields in the
    /// `TARGET_TIME_SERIES` dataset to improve model training. For more
    /// information, see
    /// FeaturizationConfig.
    ///
    /// For RELATED_TIME_SERIES datasets, `CreatePredictor` verifies that the
    /// `DataFrequency` specified when the dataset was created matches the
    /// `ForecastFrequency`. TARGET_TIME_SERIES datasets don't have this
    /// restriction.
    /// Amazon Forecast also verifies the delimiter and timestamp format. For more
    /// information, see howitworks-datasets-groups.
    ///
    /// By default, predictors are trained and evaluated at the 0.1 (P10), 0.5
    /// (P50), and 0.9
    /// (P90) quantiles. You can choose custom forecast types to train and evaluate
    /// your predictor by
    /// setting the `ForecastTypes`.
    ///
    /// **AutoML**
    ///
    /// If you want Amazon Forecast to evaluate each algorithm and choose the one
    /// that minimizes the
    /// `objective function`, set `PerformAutoML` to `true`. The
    /// `objective function` is defined as the mean of the weighted losses over the
    /// forecast types. By default, these are the p10, p50, and p90 quantile losses.
    /// For more
    /// information, see EvaluationResult.
    ///
    /// When AutoML is enabled, the following properties are disallowed:
    ///
    /// * `AlgorithmArn`
    ///
    /// * `HPOConfig`
    ///
    /// * `PerformHPO`
    ///
    /// * `TrainingParameters`
    ///
    /// To get a list of all of your predictors, use the ListPredictors
    /// operation.
    ///
    /// Before you can use the predictor to create a forecast, the `Status` of the
    /// predictor must be `ACTIVE`, signifying that training has completed. To get
    /// the
    /// status, use the DescribePredictor operation.
    pub fn createPredictor(self: *Self, allocator: std.mem.Allocator, input: create_predictor.CreatePredictorInput, options: create_predictor.Options) !create_predictor.CreatePredictorOutput {
        return create_predictor.execute(self, allocator, input, options);
    }

    /// Exports backtest forecasts and accuracy metrics generated by the
    /// CreateAutoPredictor or CreatePredictor operations. Two
    /// folders containing CSV or Parquet files are exported to your specified S3
    /// bucket.
    ///
    /// The export file names will match the following conventions:
    ///
    /// `__.csv`
    ///
    /// The component is in Java SimpleDate format
    /// (yyyy-MM-ddTHH-mm-ssZ).
    ///
    /// You must specify a DataDestination object that includes an Amazon S3
    /// bucket and an Identity and Access Management (IAM) role that Amazon Forecast
    /// can assume to access the Amazon S3
    /// bucket. For more information, see aws-forecast-iam-roles.
    ///
    /// The `Status` of the export job must be `ACTIVE` before you
    /// can access the export in your Amazon S3 bucket. To get the status, use the
    /// DescribePredictorBacktestExportJob operation.
    pub fn createPredictorBacktestExportJob(self: *Self, allocator: std.mem.Allocator, input: create_predictor_backtest_export_job.CreatePredictorBacktestExportJobInput, options: create_predictor_backtest_export_job.Options) !create_predictor_backtest_export_job.CreatePredictorBacktestExportJobOutput {
        return create_predictor_backtest_export_job.execute(self, allocator, input, options);
    }

    /// What-if analysis is a scenario modeling technique where you make a
    /// hypothetical change to a time series and
    /// compare the forecasts generated by these changes against the baseline,
    /// unchanged time series. It is important to
    /// remember that the purpose of a what-if analysis is to understand how a
    /// forecast can change given different
    /// modifications to the baseline time series.
    ///
    /// For example, imagine you are a clothing retailer who is considering an end
    /// of season sale
    /// to clear space for new styles. After creating a baseline forecast, you can
    /// use a what-if
    /// analysis to investigate how different sales tactics might affect your goals.
    ///
    /// You could create a scenario where everything is given a 25% markdown, and
    /// another where
    /// everything is given a fixed dollar markdown. You could create a scenario
    /// where the sale lasts for one week and
    /// another where the sale lasts for one month.
    /// With a what-if analysis, you can compare many different scenarios against
    /// each other.
    ///
    /// Note that a what-if analysis is meant to display what the forecasting model
    /// has learned and how it will behave in the scenarios that you are evaluating.
    /// Do not blindly use the results of the what-if analysis to make business
    /// decisions. For instance, forecasts might not be accurate for novel scenarios
    /// where there is no reference available to determine whether a forecast is
    /// good.
    ///
    /// The TimeSeriesSelector object defines the items that you want in the what-if
    /// analysis.
    pub fn createWhatIfAnalysis(self: *Self, allocator: std.mem.Allocator, input: create_what_if_analysis.CreateWhatIfAnalysisInput, options: create_what_if_analysis.Options) !create_what_if_analysis.CreateWhatIfAnalysisOutput {
        return create_what_if_analysis.execute(self, allocator, input, options);
    }

    /// A what-if forecast is a forecast that is created from a modified version of
    /// the baseline forecast. Each
    /// what-if forecast incorporates either a replacement dataset or a set of
    /// transformations to the original dataset.
    pub fn createWhatIfForecast(self: *Self, allocator: std.mem.Allocator, input: create_what_if_forecast.CreateWhatIfForecastInput, options: create_what_if_forecast.Options) !create_what_if_forecast.CreateWhatIfForecastOutput {
        return create_what_if_forecast.execute(self, allocator, input, options);
    }

    /// Exports a forecast created by the CreateWhatIfForecast operation to your
    /// Amazon Simple Storage Service (Amazon S3) bucket. The forecast file name
    /// will match the following conventions:
    ///
    /// `≈__`
    ///
    /// The component is in Java SimpleDateFormat
    /// (yyyy-MM-ddTHH-mm-ssZ).
    ///
    /// You must specify a DataDestination object that includes an Identity and
    /// Access Management
    /// (IAM) role that Amazon Forecast can assume to access the Amazon S3 bucket.
    /// For more information, see
    /// aws-forecast-iam-roles.
    ///
    /// For more information, see howitworks-forecast.
    ///
    /// To get a list of all your what-if forecast export jobs, use the
    /// ListWhatIfForecastExports
    /// operation.
    ///
    /// The `Status` of the forecast export job must be `ACTIVE` before
    /// you can access the forecast in your Amazon S3 bucket. To get the status, use
    /// the DescribeWhatIfForecastExport operation.
    pub fn createWhatIfForecastExport(self: *Self, allocator: std.mem.Allocator, input: create_what_if_forecast_export.CreateWhatIfForecastExportInput, options: create_what_if_forecast_export.Options) !create_what_if_forecast_export.CreateWhatIfForecastExportOutput {
        return create_what_if_forecast_export.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Forecast dataset that was created using the
    /// [CreateDataset](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDataset.html) operation. You can
    /// only delete datasets that have a status of `ACTIVE` or `CREATE_FAILED`.
    /// To get the status use the
    /// [DescribeDataset](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDataset.html) operation.
    ///
    /// Forecast does not automatically update any dataset groups that contain the
    /// deleted dataset.
    /// In order to update the dataset group, use the
    /// [UpdateDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_UpdateDatasetGroup.html) operation,
    /// omitting the deleted dataset's ARN.
    pub fn deleteDataset(self: *Self, allocator: std.mem.Allocator, input: delete_dataset.DeleteDatasetInput, options: delete_dataset.Options) !delete_dataset.DeleteDatasetOutput {
        return delete_dataset.execute(self, allocator, input, options);
    }

    /// Deletes a dataset group created using the
    /// [CreateDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetGroup.html) operation.
    /// You can only delete dataset groups that have a status of `ACTIVE`,
    /// `CREATE_FAILED`, or `UPDATE_FAILED`. To get the status, use the
    /// [DescribeDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDatasetGroup.html) operation.
    ///
    /// This operation deletes only the dataset group, not the datasets in the
    /// group.
    pub fn deleteDatasetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_dataset_group.DeleteDatasetGroupInput, options: delete_dataset_group.Options) !delete_dataset_group.DeleteDatasetGroupOutput {
        return delete_dataset_group.execute(self, allocator, input, options);
    }

    /// Deletes a dataset import job created using the
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetImportJob.html)
    /// operation. You can delete only dataset import jobs that have a status of
    /// `ACTIVE`
    /// or `CREATE_FAILED`. To get the status, use the
    /// [DescribeDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDatasetImportJob.html)
    /// operation.
    pub fn deleteDatasetImportJob(self: *Self, allocator: std.mem.Allocator, input: delete_dataset_import_job.DeleteDatasetImportJobInput, options: delete_dataset_import_job.Options) !delete_dataset_import_job.DeleteDatasetImportJobOutput {
        return delete_dataset_import_job.execute(self, allocator, input, options);
    }

    /// Deletes an Explainability resource.
    ///
    /// You can delete only predictor that have a status of `ACTIVE` or
    /// `CREATE_FAILED`. To get the status, use the DescribeExplainability
    /// operation.
    pub fn deleteExplainability(self: *Self, allocator: std.mem.Allocator, input: delete_explainability.DeleteExplainabilityInput, options: delete_explainability.Options) !delete_explainability.DeleteExplainabilityOutput {
        return delete_explainability.execute(self, allocator, input, options);
    }

    /// Deletes an Explainability export.
    pub fn deleteExplainabilityExport(self: *Self, allocator: std.mem.Allocator, input: delete_explainability_export.DeleteExplainabilityExportInput, options: delete_explainability_export.Options) !delete_explainability_export.DeleteExplainabilityExportOutput {
        return delete_explainability_export.execute(self, allocator, input, options);
    }

    /// Deletes a forecast created using the CreateForecast operation. You can
    /// delete only forecasts that have a status of `ACTIVE` or `CREATE_FAILED`.
    /// To get the status, use the DescribeForecast operation.
    ///
    /// You can't delete a forecast while it is being exported. After a forecast is
    /// deleted, you
    /// can no longer query the forecast.
    pub fn deleteForecast(self: *Self, allocator: std.mem.Allocator, input: delete_forecast.DeleteForecastInput, options: delete_forecast.Options) !delete_forecast.DeleteForecastOutput {
        return delete_forecast.execute(self, allocator, input, options);
    }

    /// Deletes a forecast export job created using the CreateForecastExportJob
    /// operation. You can delete only export jobs that have a status of `ACTIVE` or
    /// `CREATE_FAILED`. To get the status, use the DescribeForecastExportJob
    /// operation.
    pub fn deleteForecastExportJob(self: *Self, allocator: std.mem.Allocator, input: delete_forecast_export_job.DeleteForecastExportJobInput, options: delete_forecast_export_job.Options) !delete_forecast_export_job.DeleteForecastExportJobOutput {
        return delete_forecast_export_job.execute(self, allocator, input, options);
    }

    /// Deletes a monitor resource. You can only delete a monitor resource with a
    /// status of `ACTIVE`, `ACTIVE_STOPPED`, `CREATE_FAILED`, or `CREATE_STOPPED`.
    pub fn deleteMonitor(self: *Self, allocator: std.mem.Allocator, input: delete_monitor.DeleteMonitorInput, options: delete_monitor.Options) !delete_monitor.DeleteMonitorOutput {
        return delete_monitor.execute(self, allocator, input, options);
    }

    /// Deletes a predictor created using the DescribePredictor or CreatePredictor
    /// operations. You can delete only predictor that have a status of
    /// `ACTIVE` or `CREATE_FAILED`. To get the status, use the DescribePredictor
    /// operation.
    pub fn deletePredictor(self: *Self, allocator: std.mem.Allocator, input: delete_predictor.DeletePredictorInput, options: delete_predictor.Options) !delete_predictor.DeletePredictorOutput {
        return delete_predictor.execute(self, allocator, input, options);
    }

    /// Deletes a predictor backtest export job.
    pub fn deletePredictorBacktestExportJob(self: *Self, allocator: std.mem.Allocator, input: delete_predictor_backtest_export_job.DeletePredictorBacktestExportJobInput, options: delete_predictor_backtest_export_job.Options) !delete_predictor_backtest_export_job.DeletePredictorBacktestExportJobOutput {
        return delete_predictor_backtest_export_job.execute(self, allocator, input, options);
    }

    /// Deletes an entire resource tree. This operation will delete the parent
    /// resource and
    /// its child resources.
    ///
    /// Child resources are resources that were created from another resource. For
    /// example,
    /// when a forecast is generated from a predictor, the forecast is the child
    /// resource and
    /// the predictor is the parent resource.
    ///
    /// Amazon Forecast resources possess the following parent-child resource
    /// hierarchies:
    ///
    /// * **Dataset**: dataset import jobs
    ///
    /// * **Dataset Group**: predictors, predictor backtest
    /// export jobs, forecasts, forecast export jobs
    ///
    /// * **Predictor**: predictor backtest export jobs,
    /// forecasts, forecast export jobs
    ///
    /// * **Forecast**: forecast export jobs
    ///
    /// `DeleteResourceTree` will only delete Amazon Forecast resources, and will
    /// not
    /// delete datasets or exported files stored in Amazon S3.
    pub fn deleteResourceTree(self: *Self, allocator: std.mem.Allocator, input: delete_resource_tree.DeleteResourceTreeInput, options: delete_resource_tree.Options) !delete_resource_tree.DeleteResourceTreeOutput {
        return delete_resource_tree.execute(self, allocator, input, options);
    }

    /// Deletes a what-if analysis created using the CreateWhatIfAnalysis
    /// operation. You can delete only what-if analyses that have a status of
    /// `ACTIVE` or `CREATE_FAILED`. To get the status, use the
    /// DescribeWhatIfAnalysis operation.
    ///
    /// You can't delete a what-if analysis while any of its forecasts are being
    /// exported.
    pub fn deleteWhatIfAnalysis(self: *Self, allocator: std.mem.Allocator, input: delete_what_if_analysis.DeleteWhatIfAnalysisInput, options: delete_what_if_analysis.Options) !delete_what_if_analysis.DeleteWhatIfAnalysisOutput {
        return delete_what_if_analysis.execute(self, allocator, input, options);
    }

    /// Deletes a what-if forecast created using the CreateWhatIfForecast
    /// operation. You can delete only what-if forecasts that have a status of
    /// `ACTIVE` or `CREATE_FAILED`. To get the status, use the
    /// DescribeWhatIfForecast operation.
    ///
    /// You can't delete a what-if forecast while it is being exported. After a
    /// what-if forecast is deleted, you can no longer query the what-if analysis.
    pub fn deleteWhatIfForecast(self: *Self, allocator: std.mem.Allocator, input: delete_what_if_forecast.DeleteWhatIfForecastInput, options: delete_what_if_forecast.Options) !delete_what_if_forecast.DeleteWhatIfForecastOutput {
        return delete_what_if_forecast.execute(self, allocator, input, options);
    }

    /// Deletes a what-if forecast export created using the
    /// CreateWhatIfForecastExport
    /// operation. You can delete only what-if forecast exports that have a status
    /// of `ACTIVE` or `CREATE_FAILED`. To get the status, use the
    /// DescribeWhatIfForecastExport operation.
    pub fn deleteWhatIfForecastExport(self: *Self, allocator: std.mem.Allocator, input: delete_what_if_forecast_export.DeleteWhatIfForecastExportInput, options: delete_what_if_forecast_export.Options) !delete_what_if_forecast_export.DeleteWhatIfForecastExportOutput {
        return delete_what_if_forecast_export.execute(self, allocator, input, options);
    }

    /// Describes a predictor created using the CreateAutoPredictor operation.
    pub fn describeAutoPredictor(self: *Self, allocator: std.mem.Allocator, input: describe_auto_predictor.DescribeAutoPredictorInput, options: describe_auto_predictor.Options) !describe_auto_predictor.DescribeAutoPredictorOutput {
        return describe_auto_predictor.execute(self, allocator, input, options);
    }

    /// Describes an Amazon Forecast dataset created using the
    /// [CreateDataset](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDataset.html) operation.
    ///
    /// In addition to listing the parameters specified in the `CreateDataset`
    /// request,
    /// this operation includes the following dataset properties:
    ///
    /// * `CreationTime`
    ///
    /// * `LastModificationTime`
    ///
    /// * `Status`
    pub fn describeDataset(self: *Self, allocator: std.mem.Allocator, input: describe_dataset.DescribeDatasetInput, options: describe_dataset.Options) !describe_dataset.DescribeDatasetOutput {
        return describe_dataset.execute(self, allocator, input, options);
    }

    /// Describes a dataset group created using the
    /// [CreateDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetGroup.html)
    /// operation.
    ///
    /// In addition to listing the parameters provided in the `CreateDatasetGroup`
    /// request, this operation includes the following properties:
    ///
    /// * `DatasetArns` - The datasets belonging to the group.
    ///
    /// * `CreationTime`
    ///
    /// * `LastModificationTime`
    ///
    /// * `Status`
    pub fn describeDatasetGroup(self: *Self, allocator: std.mem.Allocator, input: describe_dataset_group.DescribeDatasetGroupInput, options: describe_dataset_group.Options) !describe_dataset_group.DescribeDatasetGroupOutput {
        return describe_dataset_group.execute(self, allocator, input, options);
    }

    /// Describes a dataset import job created using the
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetImportJob.html)
    /// operation.
    ///
    /// In addition to listing the parameters provided in the
    /// `CreateDatasetImportJob`
    /// request, this operation includes the following properties:
    ///
    /// * `CreationTime`
    ///
    /// * `LastModificationTime`
    ///
    /// * `DataSize`
    ///
    /// * `FieldStatistics`
    ///
    /// * `Status`
    ///
    /// * `Message` - If an error occurred, information about the error.
    pub fn describeDatasetImportJob(self: *Self, allocator: std.mem.Allocator, input: describe_dataset_import_job.DescribeDatasetImportJobInput, options: describe_dataset_import_job.Options) !describe_dataset_import_job.DescribeDatasetImportJobOutput {
        return describe_dataset_import_job.execute(self, allocator, input, options);
    }

    /// Describes an Explainability resource created using the CreateExplainability
    /// operation.
    pub fn describeExplainability(self: *Self, allocator: std.mem.Allocator, input: describe_explainability.DescribeExplainabilityInput, options: describe_explainability.Options) !describe_explainability.DescribeExplainabilityOutput {
        return describe_explainability.execute(self, allocator, input, options);
    }

    /// Describes an Explainability export created using the
    /// CreateExplainabilityExport operation.
    pub fn describeExplainabilityExport(self: *Self, allocator: std.mem.Allocator, input: describe_explainability_export.DescribeExplainabilityExportInput, options: describe_explainability_export.Options) !describe_explainability_export.DescribeExplainabilityExportOutput {
        return describe_explainability_export.execute(self, allocator, input, options);
    }

    /// Describes a forecast created using the CreateForecast operation.
    ///
    /// In addition to listing the properties provided in the `CreateForecast`
    /// request,
    /// this operation lists the following properties:
    ///
    /// * `DatasetGroupArn` - The dataset group that provided the training
    /// data.
    ///
    /// * `CreationTime`
    ///
    /// * `LastModificationTime`
    ///
    /// * `Status`
    ///
    /// * `Message` - If an error occurred, information about the error.
    pub fn describeForecast(self: *Self, allocator: std.mem.Allocator, input: describe_forecast.DescribeForecastInput, options: describe_forecast.Options) !describe_forecast.DescribeForecastOutput {
        return describe_forecast.execute(self, allocator, input, options);
    }

    /// Describes a forecast export job created using the CreateForecastExportJob
    /// operation.
    ///
    /// In addition to listing the properties provided by the user in the
    /// `CreateForecastExportJob` request, this operation lists the following
    /// properties:
    ///
    /// * `CreationTime`
    ///
    /// * `LastModificationTime`
    ///
    /// * `Status`
    ///
    /// * `Message` - If an error occurred, information about the error.
    pub fn describeForecastExportJob(self: *Self, allocator: std.mem.Allocator, input: describe_forecast_export_job.DescribeForecastExportJobInput, options: describe_forecast_export_job.Options) !describe_forecast_export_job.DescribeForecastExportJobOutput {
        return describe_forecast_export_job.execute(self, allocator, input, options);
    }

    /// Describes a monitor resource. In addition to listing the properties provided
    /// in the CreateMonitor request, this operation lists the following properties:
    ///
    /// * `Baseline`
    ///
    /// * `CreationTime`
    ///
    /// * `LastEvaluationTime`
    ///
    /// * `LastEvaluationState`
    ///
    /// * `LastModificationTime`
    ///
    /// * `Message`
    ///
    /// * `Status`
    pub fn describeMonitor(self: *Self, allocator: std.mem.Allocator, input: describe_monitor.DescribeMonitorInput, options: describe_monitor.Options) !describe_monitor.DescribeMonitorOutput {
        return describe_monitor.execute(self, allocator, input, options);
    }

    /// This operation is only valid for legacy predictors created with
    /// CreatePredictor. If you
    /// are not using a legacy predictor, use DescribeAutoPredictor.
    ///
    /// Describes a predictor created using the CreatePredictor
    /// operation.
    ///
    /// In addition to listing the properties provided in the `CreatePredictor`
    /// request, this operation lists the following properties:
    ///
    /// * `DatasetImportJobArns` - The dataset import jobs used to import training
    /// data.
    ///
    /// * `AutoMLAlgorithmArns` - If AutoML is performed, the algorithms that were
    /// evaluated.
    ///
    /// * `CreationTime`
    ///
    /// * `LastModificationTime`
    ///
    /// * `Status`
    ///
    /// * `Message` - If an error occurred, information about the error.
    pub fn describePredictor(self: *Self, allocator: std.mem.Allocator, input: describe_predictor.DescribePredictorInput, options: describe_predictor.Options) !describe_predictor.DescribePredictorOutput {
        return describe_predictor.execute(self, allocator, input, options);
    }

    /// Describes a predictor backtest export job created using the
    /// CreatePredictorBacktestExportJob operation.
    ///
    /// In addition to listing the properties provided by the user in the
    /// `CreatePredictorBacktestExportJob` request, this operation lists the
    /// following properties:
    ///
    /// * `CreationTime`
    ///
    /// * `LastModificationTime`
    ///
    /// * `Status`
    ///
    /// * `Message` (if an error occurred)
    pub fn describePredictorBacktestExportJob(self: *Self, allocator: std.mem.Allocator, input: describe_predictor_backtest_export_job.DescribePredictorBacktestExportJobInput, options: describe_predictor_backtest_export_job.Options) !describe_predictor_backtest_export_job.DescribePredictorBacktestExportJobOutput {
        return describe_predictor_backtest_export_job.execute(self, allocator, input, options);
    }

    /// Describes the what-if analysis created using the CreateWhatIfAnalysis
    /// operation.
    ///
    /// In addition to listing the properties provided in the `CreateWhatIfAnalysis`
    /// request, this operation lists the following properties:
    ///
    /// * `CreationTime`
    ///
    /// * `LastModificationTime`
    ///
    /// * `Message` - If an error occurred, information about the error.
    ///
    /// * `Status`
    pub fn describeWhatIfAnalysis(self: *Self, allocator: std.mem.Allocator, input: describe_what_if_analysis.DescribeWhatIfAnalysisInput, options: describe_what_if_analysis.Options) !describe_what_if_analysis.DescribeWhatIfAnalysisOutput {
        return describe_what_if_analysis.execute(self, allocator, input, options);
    }

    /// Describes the what-if forecast created using the CreateWhatIfForecast
    /// operation.
    ///
    /// In addition to listing the properties provided in the `CreateWhatIfForecast`
    /// request, this operation lists the following properties:
    ///
    /// * `CreationTime`
    ///
    /// * `LastModificationTime`
    ///
    /// * `Message` - If an error occurred, information about the error.
    ///
    /// * `Status`
    pub fn describeWhatIfForecast(self: *Self, allocator: std.mem.Allocator, input: describe_what_if_forecast.DescribeWhatIfForecastInput, options: describe_what_if_forecast.Options) !describe_what_if_forecast.DescribeWhatIfForecastOutput {
        return describe_what_if_forecast.execute(self, allocator, input, options);
    }

    /// Describes the what-if forecast export created using the
    /// CreateWhatIfForecastExport operation.
    ///
    /// In addition to listing the properties provided in the
    /// `CreateWhatIfForecastExport` request, this operation lists the following
    /// properties:
    ///
    /// * `CreationTime`
    ///
    /// * `LastModificationTime`
    ///
    /// * `Message` - If an error occurred, information about the error.
    ///
    /// * `Status`
    pub fn describeWhatIfForecastExport(self: *Self, allocator: std.mem.Allocator, input: describe_what_if_forecast_export.DescribeWhatIfForecastExportInput, options: describe_what_if_forecast_export.Options) !describe_what_if_forecast_export.DescribeWhatIfForecastExportOutput {
        return describe_what_if_forecast_export.execute(self, allocator, input, options);
    }

    /// Provides metrics on the accuracy of the models that were trained by the
    /// CreatePredictor operation. Use metrics to see how well the model performed
    /// and
    /// to decide whether to use the predictor to generate a forecast. For more
    /// information, see
    /// [Predictor
    /// Metrics](https://docs.aws.amazon.com/forecast/latest/dg/metrics.html).
    ///
    /// This operation generates metrics for each backtest window that was
    /// evaluated. The number
    /// of backtest windows (`NumberOfBacktestWindows`) is specified using the
    /// EvaluationParameters object, which is optionally included in the
    /// `CreatePredictor` request. If `NumberOfBacktestWindows` isn't
    /// specified, the number defaults to one.
    ///
    /// The parameters of the `filling` method determine which items contribute to
    /// the
    /// metrics. If you want all items to contribute, specify `zero`. If you want
    /// only
    /// those items that have complete data in the range being evaluated to
    /// contribute, specify
    /// `nan`. For more information, see FeaturizationMethod.
    ///
    /// Before you can get accuracy metrics, the `Status` of the predictor must be
    /// `ACTIVE`, signifying that training has completed. To get the status, use the
    /// DescribePredictor operation.
    pub fn getAccuracyMetrics(self: *Self, allocator: std.mem.Allocator, input: get_accuracy_metrics.GetAccuracyMetricsInput, options: get_accuracy_metrics.Options) !get_accuracy_metrics.GetAccuracyMetricsOutput {
        return get_accuracy_metrics.execute(self, allocator, input, options);
    }

    /// Returns a list of dataset groups created using the
    /// [CreateDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetGroup.html) operation.
    /// For each dataset group, this operation returns a summary of its properties,
    /// including its
    /// Amazon Resource Name (ARN). You can retrieve the complete set of properties
    /// by using the
    /// dataset group ARN with the
    /// [DescribeDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDatasetGroup.html)
    /// operation.
    pub fn listDatasetGroups(self: *Self, allocator: std.mem.Allocator, input: list_dataset_groups.ListDatasetGroupsInput, options: list_dataset_groups.Options) !list_dataset_groups.ListDatasetGroupsOutput {
        return list_dataset_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of dataset import jobs created using the
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetImportJob.html)
    /// operation. For each import job, this operation returns a summary of its
    /// properties, including
    /// its Amazon Resource Name (ARN). You can retrieve the complete set of
    /// properties by using the
    /// ARN with the
    /// [DescribeDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDatasetImportJob.html)
    /// operation. You can filter the list by providing an array of
    /// [Filter](https://docs.aws.amazon.com/forecast/latest/dg/API_Filter.html)
    /// objects.
    pub fn listDatasetImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_dataset_import_jobs.ListDatasetImportJobsInput, options: list_dataset_import_jobs.Options) !list_dataset_import_jobs.ListDatasetImportJobsOutput {
        return list_dataset_import_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of datasets created using the
    /// [CreateDataset](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDataset.html) operation. For each
    /// dataset, a summary of its properties, including its Amazon Resource Name
    /// (ARN), is returned.
    /// To retrieve the complete set of properties, use the ARN with the
    /// [DescribeDataset](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDataset.html) operation.
    pub fn listDatasets(self: *Self, allocator: std.mem.Allocator, input: list_datasets.ListDatasetsInput, options: list_datasets.Options) !list_datasets.ListDatasetsOutput {
        return list_datasets.execute(self, allocator, input, options);
    }

    /// Returns a list of Explainability resources created using the
    /// CreateExplainability operation. This operation returns a summary for
    /// each Explainability. You can filter the list using an array of Filter
    /// objects.
    ///
    /// To retrieve the complete set of properties for a particular Explainability
    /// resource,
    /// use the ARN with the DescribeExplainability operation.
    pub fn listExplainabilities(self: *Self, allocator: std.mem.Allocator, input: list_explainabilities.ListExplainabilitiesInput, options: list_explainabilities.Options) !list_explainabilities.ListExplainabilitiesOutput {
        return list_explainabilities.execute(self, allocator, input, options);
    }

    /// Returns a list of Explainability exports created using the
    /// CreateExplainabilityExport operation. This operation returns a summary
    /// for each Explainability export. You can filter the list using an array of
    /// Filter objects.
    ///
    /// To retrieve the complete set of properties for a particular Explainability
    /// export, use
    /// the ARN with the DescribeExplainability operation.
    pub fn listExplainabilityExports(self: *Self, allocator: std.mem.Allocator, input: list_explainability_exports.ListExplainabilityExportsInput, options: list_explainability_exports.Options) !list_explainability_exports.ListExplainabilityExportsOutput {
        return list_explainability_exports.execute(self, allocator, input, options);
    }

    /// Returns a list of forecast export jobs created using the
    /// CreateForecastExportJob operation. For each forecast export job, this
    /// operation
    /// returns a summary of its properties, including its Amazon Resource Name
    /// (ARN). To retrieve the
    /// complete set of properties, use the ARN with the DescribeForecastExportJob
    /// operation. You can filter the list using an array of Filter objects.
    pub fn listForecastExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_forecast_export_jobs.ListForecastExportJobsInput, options: list_forecast_export_jobs.Options) !list_forecast_export_jobs.ListForecastExportJobsOutput {
        return list_forecast_export_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of forecasts created using the CreateForecast operation.
    /// For each forecast, this operation returns a summary of its properties,
    /// including its Amazon
    /// Resource Name (ARN). To retrieve the complete set of properties, specify the
    /// ARN with the
    /// DescribeForecast operation. You can filter the list using an array of
    /// Filter objects.
    pub fn listForecasts(self: *Self, allocator: std.mem.Allocator, input: list_forecasts.ListForecastsInput, options: list_forecasts.Options) !list_forecasts.ListForecastsOutput {
        return list_forecasts.execute(self, allocator, input, options);
    }

    /// Returns a list of the monitoring evaluation results and predictor events
    /// collected by
    /// the monitor resource during different windows of time.
    ///
    /// For information about monitoring see predictor-monitoring. For
    /// more information about retrieving monitoring results see [Viewing Monitoring
    /// Results](https://docs.aws.amazon.com/forecast/latest/dg/predictor-monitoring-results.html).
    pub fn listMonitorEvaluations(self: *Self, allocator: std.mem.Allocator, input: list_monitor_evaluations.ListMonitorEvaluationsInput, options: list_monitor_evaluations.Options) !list_monitor_evaluations.ListMonitorEvaluationsOutput {
        return list_monitor_evaluations.execute(self, allocator, input, options);
    }

    /// Returns a list of monitors created with the CreateMonitor operation and
    /// CreateAutoPredictor operation. For each monitor resource, this operation
    /// returns of a summary of its properties, including its Amazon Resource Name
    /// (ARN). You
    /// can retrieve a complete set of properties of a monitor resource by specify
    /// the monitor's ARN in the DescribeMonitor operation.
    pub fn listMonitors(self: *Self, allocator: std.mem.Allocator, input: list_monitors.ListMonitorsInput, options: list_monitors.Options) !list_monitors.ListMonitorsOutput {
        return list_monitors.execute(self, allocator, input, options);
    }

    /// Returns a list of predictor backtest export jobs created using the
    /// CreatePredictorBacktestExportJob operation. This operation returns a
    /// summary for each backtest export job. You can filter the list using an array
    /// of Filter objects.
    ///
    /// To retrieve the complete set of properties for a particular backtest export
    /// job, use
    /// the ARN with the DescribePredictorBacktestExportJob operation.
    pub fn listPredictorBacktestExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_predictor_backtest_export_jobs.ListPredictorBacktestExportJobsInput, options: list_predictor_backtest_export_jobs.Options) !list_predictor_backtest_export_jobs.ListPredictorBacktestExportJobsOutput {
        return list_predictor_backtest_export_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of predictors created using the CreateAutoPredictor or
    /// CreatePredictor operations. For each predictor, this operation returns a
    /// summary of its properties, including its Amazon Resource Name (ARN).
    ///
    /// You can retrieve the complete set of properties by using the ARN with the
    /// DescribeAutoPredictor and DescribePredictor operations. You
    /// can filter the list using an array of Filter objects.
    pub fn listPredictors(self: *Self, allocator: std.mem.Allocator, input: list_predictors.ListPredictorsInput, options: list_predictors.Options) !list_predictors.ListPredictorsOutput {
        return list_predictors.execute(self, allocator, input, options);
    }

    /// Lists the tags for an Amazon Forecast resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of what-if analyses created using the CreateWhatIfAnalysis
    /// operation. For each what-if analysis, this operation returns a summary of
    /// its properties, including its Amazon Resource Name (ARN). You can retrieve
    /// the complete set of properties by using the what-if analysis ARN with the
    /// DescribeWhatIfAnalysis operation.
    pub fn listWhatIfAnalyses(self: *Self, allocator: std.mem.Allocator, input: list_what_if_analyses.ListWhatIfAnalysesInput, options: list_what_if_analyses.Options) !list_what_if_analyses.ListWhatIfAnalysesOutput {
        return list_what_if_analyses.execute(self, allocator, input, options);
    }

    /// Returns a list of what-if forecast exports created using the
    /// CreateWhatIfForecastExport operation. For each what-if forecast export, this
    /// operation returns a summary of its properties, including its Amazon Resource
    /// Name (ARN). You can retrieve the complete set of properties by using the
    /// what-if forecast export ARN with the DescribeWhatIfForecastExport operation.
    pub fn listWhatIfForecastExports(self: *Self, allocator: std.mem.Allocator, input: list_what_if_forecast_exports.ListWhatIfForecastExportsInput, options: list_what_if_forecast_exports.Options) !list_what_if_forecast_exports.ListWhatIfForecastExportsOutput {
        return list_what_if_forecast_exports.execute(self, allocator, input, options);
    }

    /// Returns a list of what-if forecasts created using the CreateWhatIfForecast
    /// operation. For each what-if forecast, this operation returns a summary of
    /// its properties, including its Amazon Resource Name (ARN). You can retrieve
    /// the complete set of properties by using the what-if forecast ARN with the
    /// DescribeWhatIfForecast operation.
    pub fn listWhatIfForecasts(self: *Self, allocator: std.mem.Allocator, input: list_what_if_forecasts.ListWhatIfForecastsInput, options: list_what_if_forecasts.Options) !list_what_if_forecasts.ListWhatIfForecastsOutput {
        return list_what_if_forecasts.execute(self, allocator, input, options);
    }

    /// Resumes a stopped monitor resource.
    pub fn resumeResource(self: *Self, allocator: std.mem.Allocator, input: resume_resource.ResumeResourceInput, options: resume_resource.Options) !resume_resource.ResumeResourceOutput {
        return resume_resource.execute(self, allocator, input, options);
    }

    /// Stops a resource.
    ///
    /// The resource undergoes the following states: `CREATE_STOPPING` and
    /// `CREATE_STOPPED`. You cannot resume a resource once it has been
    /// stopped.
    ///
    /// This operation can be applied to the following resources (and their
    /// corresponding child
    /// resources):
    ///
    /// * Dataset Import Job
    ///
    /// * Predictor Job
    ///
    /// * Forecast Job
    ///
    /// * Forecast Export Job
    ///
    /// * Predictor Backtest Export Job
    ///
    /// * Explainability Job
    ///
    /// * Explainability Export Job
    pub fn stopResource(self: *Self, allocator: std.mem.Allocator, input: stop_resource.StopResourceInput, options: stop_resource.Options) !stop_resource.StopResourceOutput {
        return stop_resource.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to a resource with the specified
    /// `resourceArn`.
    /// If existing tags on a resource are not specified in the request parameters,
    /// they are not
    /// changed. When a resource is deleted, the tags associated with that resource
    /// are also
    /// deleted.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes the specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Replaces the datasets in a dataset group with the specified datasets.
    ///
    /// The `Status` of the dataset group must be `ACTIVE` before you can
    /// use the dataset group to create a predictor. Use the
    /// [DescribeDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDatasetGroup.html)
    /// operation to get the status.
    pub fn updateDatasetGroup(self: *Self, allocator: std.mem.Allocator, input: update_dataset_group.UpdateDatasetGroupInput, options: update_dataset_group.Options) !update_dataset_group.UpdateDatasetGroupOutput {
        return update_dataset_group.execute(self, allocator, input, options);
    }

    pub fn listDatasetGroupsPaginator(self: *Self, params: list_dataset_groups.ListDatasetGroupsInput) paginator.ListDatasetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDatasetImportJobsPaginator(self: *Self, params: list_dataset_import_jobs.ListDatasetImportJobsInput) paginator.ListDatasetImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDatasetsPaginator(self: *Self, params: list_datasets.ListDatasetsInput) paginator.ListDatasetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExplainabilitiesPaginator(self: *Self, params: list_explainabilities.ListExplainabilitiesInput) paginator.ListExplainabilitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExplainabilityExportsPaginator(self: *Self, params: list_explainability_exports.ListExplainabilityExportsInput) paginator.ListExplainabilityExportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listForecastExportJobsPaginator(self: *Self, params: list_forecast_export_jobs.ListForecastExportJobsInput) paginator.ListForecastExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listForecastsPaginator(self: *Self, params: list_forecasts.ListForecastsInput) paginator.ListForecastsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMonitorEvaluationsPaginator(self: *Self, params: list_monitor_evaluations.ListMonitorEvaluationsInput) paginator.ListMonitorEvaluationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMonitorsPaginator(self: *Self, params: list_monitors.ListMonitorsInput) paginator.ListMonitorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPredictorBacktestExportJobsPaginator(self: *Self, params: list_predictor_backtest_export_jobs.ListPredictorBacktestExportJobsInput) paginator.ListPredictorBacktestExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPredictorsPaginator(self: *Self, params: list_predictors.ListPredictorsInput) paginator.ListPredictorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWhatIfAnalysesPaginator(self: *Self, params: list_what_if_analyses.ListWhatIfAnalysesInput) paginator.ListWhatIfAnalysesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWhatIfForecastExportsPaginator(self: *Self, params: list_what_if_forecast_exports.ListWhatIfForecastExportsInput) paginator.ListWhatIfForecastExportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWhatIfForecastsPaginator(self: *Self, params: list_what_if_forecasts.ListWhatIfForecastsInput) paginator.ListWhatIfForecastsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
