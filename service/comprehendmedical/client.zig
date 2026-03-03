const aws = @import("aws");
const std = @import("std");

const describe_entities_detection_v2_job = @import("describe_entities_detection_v2_job.zig");
const describe_icd10_cm_inference_job = @import("describe_icd10_cm_inference_job.zig");
const describe_phi_detection_job = @import("describe_phi_detection_job.zig");
const describe_rx_norm_inference_job = @import("describe_rx_norm_inference_job.zig");
const describe_snomedct_inference_job = @import("describe_snomedct_inference_job.zig");
const detect_entities = @import("detect_entities.zig");
const detect_entities_v2 = @import("detect_entities_v2.zig");
const detect_phi = @import("detect_phi.zig");
const infer_icd10_cm = @import("infer_icd10_cm.zig");
const infer_rx_norm = @import("infer_rx_norm.zig");
const infer_snomedct = @import("infer_snomedct.zig");
const list_entities_detection_v2_jobs = @import("list_entities_detection_v2_jobs.zig");
const list_icd10_cm_inference_jobs = @import("list_icd10_cm_inference_jobs.zig");
const list_phi_detection_jobs = @import("list_phi_detection_jobs.zig");
const list_rx_norm_inference_jobs = @import("list_rx_norm_inference_jobs.zig");
const list_snomedct_inference_jobs = @import("list_snomedct_inference_jobs.zig");
const start_entities_detection_v2_job = @import("start_entities_detection_v2_job.zig");
const start_icd10_cm_inference_job = @import("start_icd10_cm_inference_job.zig");
const start_phi_detection_job = @import("start_phi_detection_job.zig");
const start_rx_norm_inference_job = @import("start_rx_norm_inference_job.zig");
const start_snomedct_inference_job = @import("start_snomedct_inference_job.zig");
const stop_entities_detection_v2_job = @import("stop_entities_detection_v2_job.zig");
const stop_icd10_cm_inference_job = @import("stop_icd10_cm_inference_job.zig");
const stop_phi_detection_job = @import("stop_phi_detection_job.zig");
const stop_rx_norm_inference_job = @import("stop_rx_norm_inference_job.zig");
const stop_snomedct_inference_job = @import("stop_snomedct_inference_job.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ComprehendMedical";

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

    /// Gets the properties associated with a medical entities detection job. Use
    /// this operation
    /// to get the status of a detection job.
    pub fn describeEntitiesDetectionV2Job(self: *Self, allocator: std.mem.Allocator, input: describe_entities_detection_v2_job.DescribeEntitiesDetectionV2JobInput, options: CallOptions) !describe_entities_detection_v2_job.DescribeEntitiesDetectionV2JobOutput {
        return describe_entities_detection_v2_job.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with an InferICD10CM job. Use this operation
    /// to get the
    /// status of an inference job.
    pub fn describeIcd10CmInferenceJob(self: *Self, allocator: std.mem.Allocator, input: describe_icd10_cm_inference_job.DescribeICD10CMInferenceJobInput, options: CallOptions) !describe_icd10_cm_inference_job.DescribeICD10CMInferenceJobOutput {
        return describe_icd10_cm_inference_job.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with a protected health information (PHI)
    /// detection job.
    /// Use this operation to get the status of a detection job.
    pub fn describePhiDetectionJob(self: *Self, allocator: std.mem.Allocator, input: describe_phi_detection_job.DescribePHIDetectionJobInput, options: CallOptions) !describe_phi_detection_job.DescribePHIDetectionJobOutput {
        return describe_phi_detection_job.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with an InferRxNorm job. Use this operation
    /// to get the
    /// status of an inference job.
    pub fn describeRxNormInferenceJob(self: *Self, allocator: std.mem.Allocator, input: describe_rx_norm_inference_job.DescribeRxNormInferenceJobInput, options: CallOptions) !describe_rx_norm_inference_job.DescribeRxNormInferenceJobOutput {
        return describe_rx_norm_inference_job.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with an InferSNOMEDCT job. Use this operation
    /// to get the status of an inference job.
    pub fn describeSnomedctInferenceJob(self: *Self, allocator: std.mem.Allocator, input: describe_snomedct_inference_job.DescribeSNOMEDCTInferenceJobInput, options: CallOptions) !describe_snomedct_inference_job.DescribeSNOMEDCTInferenceJobOutput {
        return describe_snomedct_inference_job.execute(self, allocator, input, options);
    }

    /// The `DetectEntities` operation is deprecated. You should use the
    /// DetectEntitiesV2 operation instead.
    ///
    /// Inspects the clinical text for a variety of medical entities and returns
    /// specific
    /// information about them such as entity category, location, and confidence
    /// score on that
    /// information.
    pub fn detectEntities(self: *Self, allocator: std.mem.Allocator, input: detect_entities.DetectEntitiesInput, options: CallOptions) !detect_entities.DetectEntitiesOutput {
        return detect_entities.execute(self, allocator, input, options);
    }

    /// Inspects the clinical text for a variety of medical entities and returns
    /// specific
    /// information about them such as entity category, location, and confidence
    /// score on that
    /// information. Amazon Comprehend Medical only detects medical entities in
    /// English language
    /// texts.
    ///
    /// The `DetectEntitiesV2` operation replaces the DetectEntities
    /// operation. This new action uses a different model for determining the
    /// entities in your medical
    /// text and changes the way that some entities are returned in the output. You
    /// should use the
    /// `DetectEntitiesV2` operation in all new applications.
    ///
    /// The `DetectEntitiesV2` operation returns the `Acuity` and
    /// `Direction` entities as attributes instead of types.
    pub fn detectEntitiesV2(self: *Self, allocator: std.mem.Allocator, input: detect_entities_v2.DetectEntitiesV2Input, options: CallOptions) !detect_entities_v2.DetectEntitiesV2Output {
        return detect_entities_v2.execute(self, allocator, input, options);
    }

    /// Inspects the clinical text for protected health information (PHI) entities
    /// and returns
    /// the entity category, location, and confidence score for each entity. Amazon
    /// Comprehend Medical
    /// only detects entities in English language texts.
    pub fn detectPhi(self: *Self, allocator: std.mem.Allocator, input: detect_phi.DetectPHIInput, options: CallOptions) !detect_phi.DetectPHIOutput {
        return detect_phi.execute(self, allocator, input, options);
    }

    /// InferICD10CM detects medical conditions as entities listed in a patient
    /// record and links
    /// those entities to normalized concept identifiers in the ICD-10-CM knowledge
    /// base from the
    /// Centers for Disease Control. Amazon Comprehend Medical only detects medical
    /// entities in
    /// English language texts.
    pub fn inferIcd10Cm(self: *Self, allocator: std.mem.Allocator, input: infer_icd10_cm.InferICD10CMInput, options: CallOptions) !infer_icd10_cm.InferICD10CMOutput {
        return infer_icd10_cm.execute(self, allocator, input, options);
    }

    /// InferRxNorm detects medications as entities listed in a patient record and
    /// links to the
    /// normalized concept identifiers in the RxNorm database from the National
    /// Library of Medicine.
    /// Amazon Comprehend Medical only detects medical entities in English language
    /// texts.
    pub fn inferRxNorm(self: *Self, allocator: std.mem.Allocator, input: infer_rx_norm.InferRxNormInput, options: CallOptions) !infer_rx_norm.InferRxNormOutput {
        return infer_rx_norm.execute(self, allocator, input, options);
    }

    /// InferSNOMEDCT detects possible medical concepts as entities and links them
    /// to codes from the Systematized Nomenclature of Medicine, Clinical Terms
    /// (SNOMED-CT) ontology
    pub fn inferSnomedct(self: *Self, allocator: std.mem.Allocator, input: infer_snomedct.InferSNOMEDCTInput, options: CallOptions) !infer_snomedct.InferSNOMEDCTOutput {
        return infer_snomedct.execute(self, allocator, input, options);
    }

    /// Gets a list of medical entity detection jobs that you have submitted.
    pub fn listEntitiesDetectionV2Jobs(self: *Self, allocator: std.mem.Allocator, input: list_entities_detection_v2_jobs.ListEntitiesDetectionV2JobsInput, options: CallOptions) !list_entities_detection_v2_jobs.ListEntitiesDetectionV2JobsOutput {
        return list_entities_detection_v2_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of InferICD10CM jobs that you have submitted.
    pub fn listIcd10CmInferenceJobs(self: *Self, allocator: std.mem.Allocator, input: list_icd10_cm_inference_jobs.ListICD10CMInferenceJobsInput, options: CallOptions) !list_icd10_cm_inference_jobs.ListICD10CMInferenceJobsOutput {
        return list_icd10_cm_inference_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of protected health information (PHI) detection jobs you have
    /// submitted.
    pub fn listPhiDetectionJobs(self: *Self, allocator: std.mem.Allocator, input: list_phi_detection_jobs.ListPHIDetectionJobsInput, options: CallOptions) !list_phi_detection_jobs.ListPHIDetectionJobsOutput {
        return list_phi_detection_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of InferRxNorm jobs that you have submitted.
    pub fn listRxNormInferenceJobs(self: *Self, allocator: std.mem.Allocator, input: list_rx_norm_inference_jobs.ListRxNormInferenceJobsInput, options: CallOptions) !list_rx_norm_inference_jobs.ListRxNormInferenceJobsOutput {
        return list_rx_norm_inference_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of InferSNOMEDCT jobs a user has submitted.
    pub fn listSnomedctInferenceJobs(self: *Self, allocator: std.mem.Allocator, input: list_snomedct_inference_jobs.ListSNOMEDCTInferenceJobsInput, options: CallOptions) !list_snomedct_inference_jobs.ListSNOMEDCTInferenceJobsOutput {
        return list_snomedct_inference_jobs.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous medical entity detection job for a collection of
    /// documents. Use the
    /// `DescribeEntitiesDetectionV2Job` operation to track the status of a job.
    pub fn startEntitiesDetectionV2Job(self: *Self, allocator: std.mem.Allocator, input: start_entities_detection_v2_job.StartEntitiesDetectionV2JobInput, options: CallOptions) !start_entities_detection_v2_job.StartEntitiesDetectionV2JobOutput {
        return start_entities_detection_v2_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous job to detect medical conditions and link them to the
    /// ICD-10-CM
    /// ontology. Use the `DescribeICD10CMInferenceJob` operation to track the
    /// status of a
    /// job.
    pub fn startIcd10CmInferenceJob(self: *Self, allocator: std.mem.Allocator, input: start_icd10_cm_inference_job.StartICD10CMInferenceJobInput, options: CallOptions) !start_icd10_cm_inference_job.StartICD10CMInferenceJobOutput {
        return start_icd10_cm_inference_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous job to detect protected health information (PHI). Use
    /// the
    /// `DescribePHIDetectionJob` operation to track the status of a job.
    pub fn startPhiDetectionJob(self: *Self, allocator: std.mem.Allocator, input: start_phi_detection_job.StartPHIDetectionJobInput, options: CallOptions) !start_phi_detection_job.StartPHIDetectionJobOutput {
        return start_phi_detection_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous job to detect medication entities and link them to
    /// the RxNorm
    /// ontology. Use the `DescribeRxNormInferenceJob` operation to track the status
    /// of a
    /// job.
    pub fn startRxNormInferenceJob(self: *Self, allocator: std.mem.Allocator, input: start_rx_norm_inference_job.StartRxNormInferenceJobInput, options: CallOptions) !start_rx_norm_inference_job.StartRxNormInferenceJobOutput {
        return start_rx_norm_inference_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous job to detect medical concepts and link them to the
    /// SNOMED-CT ontology. Use the DescribeSNOMEDCTInferenceJob operation to track
    /// the status of a job.
    pub fn startSnomedctInferenceJob(self: *Self, allocator: std.mem.Allocator, input: start_snomedct_inference_job.StartSNOMEDCTInferenceJobInput, options: CallOptions) !start_snomedct_inference_job.StartSNOMEDCTInferenceJobOutput {
        return start_snomedct_inference_job.execute(self, allocator, input, options);
    }

    /// Stops a medical entities detection job in progress.
    pub fn stopEntitiesDetectionV2Job(self: *Self, allocator: std.mem.Allocator, input: stop_entities_detection_v2_job.StopEntitiesDetectionV2JobInput, options: CallOptions) !stop_entities_detection_v2_job.StopEntitiesDetectionV2JobOutput {
        return stop_entities_detection_v2_job.execute(self, allocator, input, options);
    }

    /// Stops an InferICD10CM inference job in progress.
    pub fn stopIcd10CmInferenceJob(self: *Self, allocator: std.mem.Allocator, input: stop_icd10_cm_inference_job.StopICD10CMInferenceJobInput, options: CallOptions) !stop_icd10_cm_inference_job.StopICD10CMInferenceJobOutput {
        return stop_icd10_cm_inference_job.execute(self, allocator, input, options);
    }

    /// Stops a protected health information (PHI) detection job in progress.
    pub fn stopPhiDetectionJob(self: *Self, allocator: std.mem.Allocator, input: stop_phi_detection_job.StopPHIDetectionJobInput, options: CallOptions) !stop_phi_detection_job.StopPHIDetectionJobOutput {
        return stop_phi_detection_job.execute(self, allocator, input, options);
    }

    /// Stops an InferRxNorm inference job in progress.
    pub fn stopRxNormInferenceJob(self: *Self, allocator: std.mem.Allocator, input: stop_rx_norm_inference_job.StopRxNormInferenceJobInput, options: CallOptions) !stop_rx_norm_inference_job.StopRxNormInferenceJobOutput {
        return stop_rx_norm_inference_job.execute(self, allocator, input, options);
    }

    /// Stops an InferSNOMEDCT inference job in progress.
    pub fn stopSnomedctInferenceJob(self: *Self, allocator: std.mem.Allocator, input: stop_snomedct_inference_job.StopSNOMEDCTInferenceJobInput, options: CallOptions) !stop_snomedct_inference_job.StopSNOMEDCTInferenceJobOutput {
        return stop_snomedct_inference_job.execute(self, allocator, input, options);
    }
};
