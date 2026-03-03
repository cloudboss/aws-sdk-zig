const aws = @import("aws");
const std = @import("std");

const abort_multipart_read_set_upload = @import("abort_multipart_read_set_upload.zig");
const accept_share = @import("accept_share.zig");
const batch_delete_read_set = @import("batch_delete_read_set.zig");
const cancel_annotation_import_job = @import("cancel_annotation_import_job.zig");
const cancel_run = @import("cancel_run.zig");
const cancel_variant_import_job = @import("cancel_variant_import_job.zig");
const complete_multipart_read_set_upload = @import("complete_multipart_read_set_upload.zig");
const create_annotation_store = @import("create_annotation_store.zig");
const create_annotation_store_version = @import("create_annotation_store_version.zig");
const create_multipart_read_set_upload = @import("create_multipart_read_set_upload.zig");
const create_reference_store = @import("create_reference_store.zig");
const create_run_cache = @import("create_run_cache.zig");
const create_run_group = @import("create_run_group.zig");
const create_sequence_store = @import("create_sequence_store.zig");
const create_share = @import("create_share.zig");
const create_variant_store = @import("create_variant_store.zig");
const create_workflow = @import("create_workflow.zig");
const create_workflow_version = @import("create_workflow_version.zig");
const delete_annotation_store = @import("delete_annotation_store.zig");
const delete_annotation_store_versions = @import("delete_annotation_store_versions.zig");
const delete_reference = @import("delete_reference.zig");
const delete_reference_store = @import("delete_reference_store.zig");
const delete_run = @import("delete_run.zig");
const delete_run_cache = @import("delete_run_cache.zig");
const delete_run_group = @import("delete_run_group.zig");
const delete_s3_access_policy = @import("delete_s3_access_policy.zig");
const delete_sequence_store = @import("delete_sequence_store.zig");
const delete_share = @import("delete_share.zig");
const delete_variant_store = @import("delete_variant_store.zig");
const delete_workflow = @import("delete_workflow.zig");
const delete_workflow_version = @import("delete_workflow_version.zig");
const get_annotation_import_job = @import("get_annotation_import_job.zig");
const get_annotation_store = @import("get_annotation_store.zig");
const get_annotation_store_version = @import("get_annotation_store_version.zig");
const get_read_set = @import("get_read_set.zig");
const get_read_set_activation_job = @import("get_read_set_activation_job.zig");
const get_read_set_export_job = @import("get_read_set_export_job.zig");
const get_read_set_import_job = @import("get_read_set_import_job.zig");
const get_read_set_metadata = @import("get_read_set_metadata.zig");
const get_reference = @import("get_reference.zig");
const get_reference_import_job = @import("get_reference_import_job.zig");
const get_reference_metadata = @import("get_reference_metadata.zig");
const get_reference_store = @import("get_reference_store.zig");
const get_run = @import("get_run.zig");
const get_run_cache = @import("get_run_cache.zig");
const get_run_group = @import("get_run_group.zig");
const get_run_task = @import("get_run_task.zig");
const get_s3_access_policy = @import("get_s3_access_policy.zig");
const get_sequence_store = @import("get_sequence_store.zig");
const get_share = @import("get_share.zig");
const get_variant_import_job = @import("get_variant_import_job.zig");
const get_variant_store = @import("get_variant_store.zig");
const get_workflow = @import("get_workflow.zig");
const get_workflow_version = @import("get_workflow_version.zig");
const list_annotation_import_jobs = @import("list_annotation_import_jobs.zig");
const list_annotation_store_versions = @import("list_annotation_store_versions.zig");
const list_annotation_stores = @import("list_annotation_stores.zig");
const list_multipart_read_set_uploads = @import("list_multipart_read_set_uploads.zig");
const list_read_set_activation_jobs = @import("list_read_set_activation_jobs.zig");
const list_read_set_export_jobs = @import("list_read_set_export_jobs.zig");
const list_read_set_import_jobs = @import("list_read_set_import_jobs.zig");
const list_read_set_upload_parts = @import("list_read_set_upload_parts.zig");
const list_read_sets = @import("list_read_sets.zig");
const list_reference_import_jobs = @import("list_reference_import_jobs.zig");
const list_reference_stores = @import("list_reference_stores.zig");
const list_references = @import("list_references.zig");
const list_run_caches = @import("list_run_caches.zig");
const list_run_groups = @import("list_run_groups.zig");
const list_run_tasks = @import("list_run_tasks.zig");
const list_runs = @import("list_runs.zig");
const list_sequence_stores = @import("list_sequence_stores.zig");
const list_shares = @import("list_shares.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_variant_import_jobs = @import("list_variant_import_jobs.zig");
const list_variant_stores = @import("list_variant_stores.zig");
const list_workflow_versions = @import("list_workflow_versions.zig");
const list_workflows = @import("list_workflows.zig");
const put_s3_access_policy = @import("put_s3_access_policy.zig");
const start_annotation_import_job = @import("start_annotation_import_job.zig");
const start_read_set_activation_job = @import("start_read_set_activation_job.zig");
const start_read_set_export_job = @import("start_read_set_export_job.zig");
const start_read_set_import_job = @import("start_read_set_import_job.zig");
const start_reference_import_job = @import("start_reference_import_job.zig");
const start_run = @import("start_run.zig");
const start_variant_import_job = @import("start_variant_import_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_annotation_store = @import("update_annotation_store.zig");
const update_annotation_store_version = @import("update_annotation_store_version.zig");
const update_run_cache = @import("update_run_cache.zig");
const update_run_group = @import("update_run_group.zig");
const update_sequence_store = @import("update_sequence_store.zig");
const update_variant_store = @import("update_variant_store.zig");
const update_workflow = @import("update_workflow.zig");
const update_workflow_version = @import("update_workflow_version.zig");
const upload_read_set_part = @import("upload_read_set_part.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Omics";

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

    /// Stops a multipart read set upload into a sequence store and returns a
    /// response with no body if the operation is successful. To confirm that a
    /// multipart read set upload has been stopped, use the
    /// `ListMultipartReadSetUploads` API operation to view all active multipart
    /// read set uploads.
    pub fn abortMultipartReadSetUpload(self: *Self, allocator: std.mem.Allocator, input: abort_multipart_read_set_upload.AbortMultipartReadSetUploadInput, options: abort_multipart_read_set_upload.Options) !abort_multipart_read_set_upload.AbortMultipartReadSetUploadOutput {
        return abort_multipart_read_set_upload.execute(self, allocator, input, options);
    }

    /// Accept a resource share request.
    pub fn acceptShare(self: *Self, allocator: std.mem.Allocator, input: accept_share.AcceptShareInput, options: accept_share.Options) !accept_share.AcceptShareOutput {
        return accept_share.execute(self, allocator, input, options);
    }

    /// Deletes one or more read sets. If the operation is successful, it returns a
    /// response with no body. If there is an error with deleting one of the read
    /// sets, the operation returns an error list. If the operation successfully
    /// deletes only a subset of files, it will return an error list for the
    /// remaining files that fail to be deleted. There is a limit of 100 read sets
    /// that can be deleted in each `BatchDeleteReadSet` API call.
    pub fn batchDeleteReadSet(self: *Self, allocator: std.mem.Allocator, input: batch_delete_read_set.BatchDeleteReadSetInput, options: batch_delete_read_set.Options) !batch_delete_read_set.BatchDeleteReadSetOutput {
        return batch_delete_read_set.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Cancels an annotation import job.
    pub fn cancelAnnotationImportJob(self: *Self, allocator: std.mem.Allocator, input: cancel_annotation_import_job.CancelAnnotationImportJobInput, options: cancel_annotation_import_job.Options) !cancel_annotation_import_job.CancelAnnotationImportJobOutput {
        return cancel_annotation_import_job.execute(self, allocator, input, options);
    }

    /// Cancels a run using its ID and returns a response with no body if the
    /// operation is successful. To confirm that the run has been cancelled, use the
    /// `ListRuns` API operation to check that it is no longer listed.
    pub fn cancelRun(self: *Self, allocator: std.mem.Allocator, input: cancel_run.CancelRunInput, options: cancel_run.Options) !cancel_run.CancelRunOutput {
        return cancel_run.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Cancels a variant import job.
    pub fn cancelVariantImportJob(self: *Self, allocator: std.mem.Allocator, input: cancel_variant_import_job.CancelVariantImportJobInput, options: cancel_variant_import_job.Options) !cancel_variant_import_job.CancelVariantImportJobOutput {
        return cancel_variant_import_job.execute(self, allocator, input, options);
    }

    /// Completes a multipart read set upload into a sequence store after you have
    /// initiated the upload process with `CreateMultipartReadSetUpload` and
    /// uploaded all read set parts using `UploadReadSetPart`. You must specify the
    /// parts you uploaded using the parts parameter. If the operation is
    /// successful, it returns the read set ID(s) of the uploaded read set(s).
    ///
    /// For more information, see [Direct upload to a sequence
    /// store](https://docs.aws.amazon.com/omics/latest/dev/synchronous-uploads.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn completeMultipartReadSetUpload(self: *Self, allocator: std.mem.Allocator, input: complete_multipart_read_set_upload.CompleteMultipartReadSetUploadInput, options: complete_multipart_read_set_upload.Options) !complete_multipart_read_set_upload.CompleteMultipartReadSetUploadOutput {
        return complete_multipart_read_set_upload.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Creates an annotation store.
    pub fn createAnnotationStore(self: *Self, allocator: std.mem.Allocator, input: create_annotation_store.CreateAnnotationStoreInput, options: create_annotation_store.Options) !create_annotation_store.CreateAnnotationStoreOutput {
        return create_annotation_store.execute(self, allocator, input, options);
    }

    /// Creates a new version of an annotation store.
    pub fn createAnnotationStoreVersion(self: *Self, allocator: std.mem.Allocator, input: create_annotation_store_version.CreateAnnotationStoreVersionInput, options: create_annotation_store_version.Options) !create_annotation_store_version.CreateAnnotationStoreVersionOutput {
        return create_annotation_store_version.execute(self, allocator, input, options);
    }

    /// Initiates a multipart read set upload for uploading partitioned source files
    /// into a sequence store. You can directly import source files from an EC2
    /// instance and other local compute, or from an S3 bucket. To separate these
    /// source files into parts, use the `split` operation. Each part cannot be
    /// larger than 100 MB. If the operation is successful, it provides an
    /// `uploadId` which is required by the `UploadReadSetPart` API operation to
    /// upload parts into a sequence store.
    ///
    /// To continue uploading a multipart read set into your sequence store, you
    /// must use the `UploadReadSetPart` API operation to upload each part
    /// individually following the steps below:
    ///
    /// * Specify the `uploadId` obtained from the previous call to
    ///   `CreateMultipartReadSetUpload`.
    /// * Upload parts for that `uploadId`.
    ///
    /// When you have finished uploading parts, use the
    /// `CompleteMultipartReadSetUpload` API to complete the multipart read set
    /// upload and to retrieve the final read set IDs in the response.
    ///
    /// To learn more about creating parts and the `split` operation, see [Direct
    /// upload to a sequence
    /// store](https://docs.aws.amazon.com/omics/latest/dev/synchronous-uploads.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn createMultipartReadSetUpload(self: *Self, allocator: std.mem.Allocator, input: create_multipart_read_set_upload.CreateMultipartReadSetUploadInput, options: create_multipart_read_set_upload.Options) !create_multipart_read_set_upload.CreateMultipartReadSetUploadOutput {
        return create_multipart_read_set_upload.execute(self, allocator, input, options);
    }

    /// Creates a reference store and returns metadata in JSON format. Reference
    /// stores are used to store reference genomes in FASTA format. A reference
    /// store is created when the first reference genome is imported. To import
    /// additional reference genomes from an Amazon S3 bucket, use the
    /// `StartReferenceImportJob` API operation.
    ///
    /// For more information, see [Creating a HealthOmics reference
    /// store](https://docs.aws.amazon.com/omics/latest/dev/create-reference-store.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn createReferenceStore(self: *Self, allocator: std.mem.Allocator, input: create_reference_store.CreateReferenceStoreInput, options: create_reference_store.Options) !create_reference_store.CreateReferenceStoreOutput {
        return create_reference_store.execute(self, allocator, input, options);
    }

    /// Creates a run cache to store and reference task outputs from completed
    /// private runs. Specify an Amazon S3 location where Amazon Web Services
    /// HealthOmics saves the cached data. This data must be immediately accessible
    /// and not in an archived state. You can save intermediate task files to a run
    /// cache if they are declared as task outputs in the workflow definition file.
    ///
    /// For more information, see [Call
    /// caching](https://docs.aws.amazon.com/omics/latest/dev/workflows-call-caching.html) and [Creating a run cache](https://docs.aws.amazon.com/omics/latest/dev/workflow-cache-create.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn createRunCache(self: *Self, allocator: std.mem.Allocator, input: create_run_cache.CreateRunCacheInput, options: create_run_cache.Options) !create_run_cache.CreateRunCacheOutput {
        return create_run_cache.execute(self, allocator, input, options);
    }

    /// Creates a run group to limit the compute resources for the runs that are
    /// added to the group. Returns an ARN, ID, and tags for the run group.
    pub fn createRunGroup(self: *Self, allocator: std.mem.Allocator, input: create_run_group.CreateRunGroupInput, options: create_run_group.Options) !create_run_group.CreateRunGroupOutput {
        return create_run_group.execute(self, allocator, input, options);
    }

    /// Creates a sequence store and returns its metadata. Sequence stores are used
    /// to store sequence data files called read sets that are saved in FASTQ, BAM,
    /// uBAM, or CRAM formats. For aligned formats (BAM and CRAM), a sequence store
    /// can only use one reference genome. For unaligned formats (FASTQ and uBAM), a
    /// reference genome is not required. You can create multiple sequence stores
    /// per region per account.
    ///
    /// The following are optional parameters you can specify for your sequence
    /// store:
    ///
    /// * Use `s3AccessConfig` to configure your sequence store with S3 access logs
    ///   (recommended).
    /// * Use `sseConfig` to define your own KMS key for encryption.
    /// * Use `eTagAlgorithmFamily` to define which algorithm to use for the
    ///   HealthOmics eTag on objects.
    /// * Use `fallbackLocation` to define a backup location for storing files that
    ///   have failed a direct upload.
    /// * Use `propagatedSetLevelTags` to configure tags that propagate to all
    ///   objects in your store.
    ///
    /// For more information, see [Creating a HealthOmics sequence
    /// store](https://docs.aws.amazon.com/omics/latest/dev/create-sequence-store.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn createSequenceStore(self: *Self, allocator: std.mem.Allocator, input: create_sequence_store.CreateSequenceStoreInput, options: create_sequence_store.Options) !create_sequence_store.CreateSequenceStoreOutput {
        return create_sequence_store.execute(self, allocator, input, options);
    }

    /// Creates a cross-account shared resource. The resource owner makes an offer
    /// to share the resource with the principal subscriber (an AWS user with a
    /// different account than the resource owner).
    ///
    /// The following resources support cross-account sharing:
    ///
    /// * HealthOmics variant stores
    /// * HealthOmics annotation stores
    /// * Private workflows
    pub fn createShare(self: *Self, allocator: std.mem.Allocator, input: create_share.CreateShareInput, options: create_share.Options) !create_share.CreateShareOutput {
        return create_share.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Creates a variant store.
    pub fn createVariantStore(self: *Self, allocator: std.mem.Allocator, input: create_variant_store.CreateVariantStoreInput, options: create_variant_store.Options) !create_variant_store.CreateVariantStoreOutput {
        return create_variant_store.execute(self, allocator, input, options);
    }

    /// Creates a private workflow. Before you create a private workflow, you must
    /// create and configure these required resources:
    ///
    /// * *Workflow definition file:* A workflow definition file written in WDL,
    ///   Nextflow, or CWL. The workflow definition specifies the inputs and outputs
    ///   for runs that use the workflow. It also includes specifications for the
    ///   runs and run tasks for your workflow, including compute and memory
    ///   requirements. The workflow definition file must be in `.zip` format. For
    ///   more information, see [Workflow definition
    ///   files](https://docs.aws.amazon.com/omics/latest/dev/workflow-definition-files.html) in Amazon Web Services HealthOmics.
    ///
    /// * You can use Amazon Q CLI to build and validate your workflow definition
    ///   files in WDL, Nextflow, and CWL. For more information, see [Example
    ///   prompts for Amazon Q
    ///   CLI](https://docs.aws.amazon.com/omics/latest/dev/getting-started.html#omics-q-prompts) and the [Amazon Web Services HealthOmics Agentic generative AI tutorial](https://github.com/aws-samples/aws-healthomics-tutorials/tree/main/generative-ai) on GitHub.
    ///
    /// * *(Optional) Parameter template file:* A parameter template file written in
    ///   JSON. Create the file to define the run parameters, or Amazon Web Services
    ///   HealthOmics generates the parameter template for you. For more
    ///   information, see [Parameter template files for HealthOmics
    ///   workflows](https://docs.aws.amazon.com/omics/latest/dev/parameter-templates.html).
    /// * *ECR container images:* Create container images for the workflow in a
    ///   private ECR repository, or synchronize images from a supported upstream
    ///   registry with your Amazon ECR private repository.
    /// * *(Optional) Sentieon licenses:* Request a Sentieon license to use the
    ///   Sentieon software in private workflows.
    ///
    /// For more information, see [Creating or updating a private workflow in Amazon
    /// Web Services
    /// HealthOmics](https://docs.aws.amazon.com/omics/latest/dev/creating-private-workflows.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn createWorkflow(self: *Self, allocator: std.mem.Allocator, input: create_workflow.CreateWorkflowInput, options: create_workflow.Options) !create_workflow.CreateWorkflowOutput {
        return create_workflow.execute(self, allocator, input, options);
    }

    /// Creates a new workflow version for the workflow that you specify with the
    /// `workflowId` parameter.
    ///
    /// When you create a new version of a workflow, you need to specify the
    /// configuration for the new version. It doesn't inherit any configuration
    /// values from the workflow.
    ///
    /// Provide a version name that is unique for this workflow. You cannot change
    /// the name after HealthOmics creates the version.
    ///
    /// Don't include any personally identifiable information (PII) in the version
    /// name. Version names appear in the workflow version ARN.
    ///
    /// For more information, see [Workflow versioning in Amazon Web Services
    /// HealthOmics](https://docs.aws.amazon.com/omics/latest/dev/workflow-versions.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn createWorkflowVersion(self: *Self, allocator: std.mem.Allocator, input: create_workflow_version.CreateWorkflowVersionInput, options: create_workflow_version.Options) !create_workflow_version.CreateWorkflowVersionOutput {
        return create_workflow_version.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Deletes an annotation store.
    pub fn deleteAnnotationStore(self: *Self, allocator: std.mem.Allocator, input: delete_annotation_store.DeleteAnnotationStoreInput, options: delete_annotation_store.Options) !delete_annotation_store.DeleteAnnotationStoreOutput {
        return delete_annotation_store.execute(self, allocator, input, options);
    }

    /// Deletes one or multiple versions of an annotation store.
    pub fn deleteAnnotationStoreVersions(self: *Self, allocator: std.mem.Allocator, input: delete_annotation_store_versions.DeleteAnnotationStoreVersionsInput, options: delete_annotation_store_versions.Options) !delete_annotation_store_versions.DeleteAnnotationStoreVersionsOutput {
        return delete_annotation_store_versions.execute(self, allocator, input, options);
    }

    /// Deletes a reference genome and returns a response with no body if the
    /// operation is successful. The read set associated with the reference genome
    /// must first be deleted before deleting the reference genome. After the
    /// reference genome is deleted, you can delete the reference store using the
    /// `DeleteReferenceStore` API operation.
    ///
    /// For more information, see [Deleting HealthOmics reference and sequence
    /// stores](https://docs.aws.amazon.com/omics/latest/dev/deleting-reference-and-sequence-stores.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn deleteReference(self: *Self, allocator: std.mem.Allocator, input: delete_reference.DeleteReferenceInput, options: delete_reference.Options) !delete_reference.DeleteReferenceOutput {
        return delete_reference.execute(self, allocator, input, options);
    }

    /// Deletes a reference store and returns a response with no body if the
    /// operation is successful. You can only delete a reference store when it does
    /// not contain any reference genomes. To empty a reference store, use
    /// `DeleteReference`.
    ///
    /// For more information about your workflow status, see [Deleting HealthOmics
    /// reference and sequence
    /// stores](https://docs.aws.amazon.com/omics/latest/dev/deleting-reference-and-sequence-stores.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn deleteReferenceStore(self: *Self, allocator: std.mem.Allocator, input: delete_reference_store.DeleteReferenceStoreInput, options: delete_reference_store.Options) !delete_reference_store.DeleteReferenceStoreOutput {
        return delete_reference_store.execute(self, allocator, input, options);
    }

    /// Deletes a run and returns a response with no body if the operation is
    /// successful. You can only delete a run that has reached a `COMPLETED`,
    /// `FAILED`, or `CANCELLED` stage. A completed run has delivered an output, or
    /// was cancelled and resulted in no output. When you delete a run, only the
    /// metadata associated with the run is deleted. The run outputs remain in
    /// Amazon S3 and logs remain in CloudWatch.
    ///
    /// To verify that the workflow is deleted:
    ///
    /// * Use `ListRuns` to confirm the workflow no longer appears in the list.
    /// * Use `GetRun` to verify the workflow cannot be found.
    pub fn deleteRun(self: *Self, allocator: std.mem.Allocator, input: delete_run.DeleteRunInput, options: delete_run.Options) !delete_run.DeleteRunOutput {
        return delete_run.execute(self, allocator, input, options);
    }

    /// Deletes a run cache and returns a response with no body if the operation is
    /// successful. This action removes the cache metadata stored in the service
    /// account, but does not delete the data in Amazon S3. You can access the cache
    /// data in Amazon S3, for inspection or to troubleshoot issues. You can remove
    /// old cache data using standard S3 `Delete` operations.
    ///
    /// For more information, see [Deleting a run
    /// cache](https://docs.aws.amazon.com/omics/latest/dev/workflow-cache-delete.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn deleteRunCache(self: *Self, allocator: std.mem.Allocator, input: delete_run_cache.DeleteRunCacheInput, options: delete_run_cache.Options) !delete_run_cache.DeleteRunCacheOutput {
        return delete_run_cache.execute(self, allocator, input, options);
    }

    /// Deletes a run group and returns a response with no body if the operation is
    /// successful.
    ///
    /// To verify that the run group is deleted:
    ///
    /// * Use `ListRunGroups` to confirm the workflow no longer appears in the list.
    /// * Use `GetRunGroup` to verify the workflow cannot be found.
    pub fn deleteRunGroup(self: *Self, allocator: std.mem.Allocator, input: delete_run_group.DeleteRunGroupInput, options: delete_run_group.Options) !delete_run_group.DeleteRunGroupOutput {
        return delete_run_group.execute(self, allocator, input, options);
    }

    /// Deletes an access policy for the specified store.
    pub fn deleteS3AccessPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_s3_access_policy.DeleteS3AccessPolicyInput, options: delete_s3_access_policy.Options) !delete_s3_access_policy.DeleteS3AccessPolicyOutput {
        return delete_s3_access_policy.execute(self, allocator, input, options);
    }

    /// Deletes a sequence store and returns a response with no body if the
    /// operation is successful. You can only delete a sequence store when it does
    /// not contain any read sets.
    ///
    /// Use the `BatchDeleteReadSet` API operation to ensure that all read sets in
    /// the sequence store are deleted. When a sequence store is deleted, all tags
    /// associated with the store are also deleted.
    ///
    /// For more information, see [Deleting HealthOmics reference and sequence
    /// stores](https://docs.aws.amazon.com/omics/latest/dev/deleting-reference-and-sequence-stores.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn deleteSequenceStore(self: *Self, allocator: std.mem.Allocator, input: delete_sequence_store.DeleteSequenceStoreInput, options: delete_sequence_store.Options) !delete_sequence_store.DeleteSequenceStoreOutput {
        return delete_sequence_store.execute(self, allocator, input, options);
    }

    /// Deletes a resource share. If you are the resource owner, the subscriber will
    /// no longer have access to the shared resource. If you are the subscriber,
    /// this operation deletes your access to the share.
    pub fn deleteShare(self: *Self, allocator: std.mem.Allocator, input: delete_share.DeleteShareInput, options: delete_share.Options) !delete_share.DeleteShareOutput {
        return delete_share.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Deletes a variant store.
    pub fn deleteVariantStore(self: *Self, allocator: std.mem.Allocator, input: delete_variant_store.DeleteVariantStoreInput, options: delete_variant_store.Options) !delete_variant_store.DeleteVariantStoreOutput {
        return delete_variant_store.execute(self, allocator, input, options);
    }

    /// Deletes a workflow by specifying its ID. This operation returns a response
    /// with no body if the deletion is successful.
    ///
    /// To verify that the workflow is deleted:
    ///
    /// * Use `ListWorkflows` to confirm the workflow no longer appears in the list.
    /// * Use `GetWorkflow` to verify the workflow cannot be found.
    pub fn deleteWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_workflow.DeleteWorkflowInput, options: delete_workflow.Options) !delete_workflow.DeleteWorkflowOutput {
        return delete_workflow.execute(self, allocator, input, options);
    }

    /// Deletes a workflow version. Deleting a workflow version doesn't affect any
    /// ongoing runs that are using the workflow version.
    ///
    /// For more information, see [Workflow versioning in Amazon Web Services
    /// HealthOmics](https://docs.aws.amazon.com/omics/latest/dev/workflow-versions.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn deleteWorkflowVersion(self: *Self, allocator: std.mem.Allocator, input: delete_workflow_version.DeleteWorkflowVersionInput, options: delete_workflow_version.Options) !delete_workflow_version.DeleteWorkflowVersionOutput {
        return delete_workflow_version.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Gets information about an annotation import job.
    pub fn getAnnotationImportJob(self: *Self, allocator: std.mem.Allocator, input: get_annotation_import_job.GetAnnotationImportJobInput, options: get_annotation_import_job.Options) !get_annotation_import_job.GetAnnotationImportJobOutput {
        return get_annotation_import_job.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Gets information about an annotation store.
    pub fn getAnnotationStore(self: *Self, allocator: std.mem.Allocator, input: get_annotation_store.GetAnnotationStoreInput, options: get_annotation_store.Options) !get_annotation_store.GetAnnotationStoreOutput {
        return get_annotation_store.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for an annotation store version.
    pub fn getAnnotationStoreVersion(self: *Self, allocator: std.mem.Allocator, input: get_annotation_store_version.GetAnnotationStoreVersionInput, options: get_annotation_store_version.Options) !get_annotation_store_version.GetAnnotationStoreVersionOutput {
        return get_annotation_store_version.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information from parts of a read set and returns the read
    /// set in the same format that it was uploaded. You must have read sets
    /// uploaded to your sequence store in order to run this operation.
    pub fn getReadSet(self: *Self, allocator: std.mem.Allocator, input: get_read_set.GetReadSetInput, options: get_read_set.Options) !get_read_set.GetReadSetOutput {
        return get_read_set.execute(self, allocator, input, options);
    }

    /// Returns detailed information about the status of a read set activation job
    /// in JSON format.
    pub fn getReadSetActivationJob(self: *Self, allocator: std.mem.Allocator, input: get_read_set_activation_job.GetReadSetActivationJobInput, options: get_read_set_activation_job.Options) !get_read_set_activation_job.GetReadSetActivationJobOutput {
        return get_read_set_activation_job.execute(self, allocator, input, options);
    }

    /// Retrieves status information about a read set export job and returns the
    /// data in JSON format. Use this operation to actively monitor the progress of
    /// an export job.
    pub fn getReadSetExportJob(self: *Self, allocator: std.mem.Allocator, input: get_read_set_export_job.GetReadSetExportJobInput, options: get_read_set_export_job.Options) !get_read_set_export_job.GetReadSetExportJobOutput {
        return get_read_set_export_job.execute(self, allocator, input, options);
    }

    /// Gets detailed and status information about a read set import job and returns
    /// the data in JSON format.
    pub fn getReadSetImportJob(self: *Self, allocator: std.mem.Allocator, input: get_read_set_import_job.GetReadSetImportJobInput, options: get_read_set_import_job.Options) !get_read_set_import_job.GetReadSetImportJobOutput {
        return get_read_set_import_job.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for a read set from a sequence store in JSON format.
    /// This operation does not return tags. To retrieve the list of tags for a read
    /// set, use the `ListTagsForResource` API operation.
    pub fn getReadSetMetadata(self: *Self, allocator: std.mem.Allocator, input: get_read_set_metadata.GetReadSetMetadataInput, options: get_read_set_metadata.Options) !get_read_set_metadata.GetReadSetMetadataOutput {
        return get_read_set_metadata.execute(self, allocator, input, options);
    }

    /// Downloads parts of data from a reference genome and returns the reference
    /// file in the same format that it was uploaded.
    ///
    /// For more information, see [Creating a HealthOmics reference
    /// store](https://docs.aws.amazon.com/omics/latest/dev/create-reference-store.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn getReference(self: *Self, allocator: std.mem.Allocator, input: get_reference.GetReferenceInput, options: get_reference.Options) !get_reference.GetReferenceOutput {
        return get_reference.execute(self, allocator, input, options);
    }

    /// Monitors the status of a reference import job. This operation can be called
    /// after calling the `StartReferenceImportJob` operation.
    pub fn getReferenceImportJob(self: *Self, allocator: std.mem.Allocator, input: get_reference_import_job.GetReferenceImportJobInput, options: get_reference_import_job.Options) !get_reference_import_job.GetReferenceImportJobOutput {
        return get_reference_import_job.execute(self, allocator, input, options);
    }

    /// Retrieves metadata for a reference genome. This operation returns the number
    /// of parts, part size, and MD5 of an entire file. This operation does not
    /// return tags. To retrieve the list of tags for a read set, use the
    /// `ListTagsForResource` API operation.
    pub fn getReferenceMetadata(self: *Self, allocator: std.mem.Allocator, input: get_reference_metadata.GetReferenceMetadataInput, options: get_reference_metadata.Options) !get_reference_metadata.GetReferenceMetadataOutput {
        return get_reference_metadata.execute(self, allocator, input, options);
    }

    /// Gets information about a reference store.
    pub fn getReferenceStore(self: *Self, allocator: std.mem.Allocator, input: get_reference_store.GetReferenceStoreInput, options: get_reference_store.Options) !get_reference_store.GetReferenceStoreOutput {
        return get_reference_store.execute(self, allocator, input, options);
    }

    /// Gets detailed information about a specific run using its ID.
    ///
    /// Amazon Web Services HealthOmics stores a configurable number of runs, as
    /// determined by service limits, that are available to the console and API. If
    /// `GetRun` does not return the requested run, you can find all run logs in the
    /// CloudWatch logs. For more information about viewing the run logs, see
    /// [CloudWatch
    /// logs](https://docs.aws.amazon.com/omics/latest/dev/monitoring-cloudwatch-logs.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn getRun(self: *Self, allocator: std.mem.Allocator, input: get_run.GetRunInput, options: get_run.Options) !get_run.GetRunOutput {
        return get_run.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about the specified run cache using its ID.
    ///
    /// For more information, see [Call caching for Amazon Web Services HealthOmics
    /// runs](https://docs.aws.amazon.com/omics/latest/dev/workflows-call-caching.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn getRunCache(self: *Self, allocator: std.mem.Allocator, input: get_run_cache.GetRunCacheInput, options: get_run_cache.Options) !get_run_cache.GetRunCacheOutput {
        return get_run_cache.execute(self, allocator, input, options);
    }

    /// Gets information about a run group and returns its metadata.
    pub fn getRunGroup(self: *Self, allocator: std.mem.Allocator, input: get_run_group.GetRunGroupInput, options: get_run_group.Options) !get_run_group.GetRunGroupOutput {
        return get_run_group.execute(self, allocator, input, options);
    }

    /// Gets detailed information about a run task using its ID.
    pub fn getRunTask(self: *Self, allocator: std.mem.Allocator, input: get_run_task.GetRunTaskInput, options: get_run_task.Options) !get_run_task.GetRunTaskOutput {
        return get_run_task.execute(self, allocator, input, options);
    }

    /// Retrieves details about an access policy on a given store.
    pub fn getS3AccessPolicy(self: *Self, allocator: std.mem.Allocator, input: get_s3_access_policy.GetS3AccessPolicyInput, options: get_s3_access_policy.Options) !get_s3_access_policy.GetS3AccessPolicyOutput {
        return get_s3_access_policy.execute(self, allocator, input, options);
    }

    /// Retrieves metadata for a sequence store using its ID and returns it in JSON
    /// format.
    pub fn getSequenceStore(self: *Self, allocator: std.mem.Allocator, input: get_sequence_store.GetSequenceStoreInput, options: get_sequence_store.Options) !get_sequence_store.GetSequenceStoreOutput {
        return get_sequence_store.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for the specified resource share.
    pub fn getShare(self: *Self, allocator: std.mem.Allocator, input: get_share.GetShareInput, options: get_share.Options) !get_share.GetShareOutput {
        return get_share.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Gets information about a variant import job.
    pub fn getVariantImportJob(self: *Self, allocator: std.mem.Allocator, input: get_variant_import_job.GetVariantImportJobInput, options: get_variant_import_job.Options) !get_variant_import_job.GetVariantImportJobOutput {
        return get_variant_import_job.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Gets information about a variant store.
    pub fn getVariantStore(self: *Self, allocator: std.mem.Allocator, input: get_variant_store.GetVariantStoreInput, options: get_variant_store.Options) !get_variant_store.GetVariantStoreOutput {
        return get_variant_store.execute(self, allocator, input, options);
    }

    /// Gets all information about a workflow using its ID.
    ///
    /// If a workflow is shared with you, you cannot export the workflow.
    ///
    /// For more information about your workflow status, see [Verify the workflow
    /// status](https://docs.aws.amazon.com/omics/latest/dev/using-get-workflow.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn getWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_workflow.GetWorkflowInput, options: get_workflow.Options) !get_workflow.GetWorkflowOutput {
        return get_workflow.execute(self, allocator, input, options);
    }

    /// Gets information about a workflow version. For more information, see
    /// [Workflow versioning in Amazon Web Services
    /// HealthOmics](https://docs.aws.amazon.com/omics/latest/dev/workflow-versions.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn getWorkflowVersion(self: *Self, allocator: std.mem.Allocator, input: get_workflow_version.GetWorkflowVersionInput, options: get_workflow_version.Options) !get_workflow_version.GetWorkflowVersionOutput {
        return get_workflow_version.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Retrieves a list of annotation import jobs.
    pub fn listAnnotationImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_annotation_import_jobs.ListAnnotationImportJobsInput, options: list_annotation_import_jobs.Options) !list_annotation_import_jobs.ListAnnotationImportJobsOutput {
        return list_annotation_import_jobs.execute(self, allocator, input, options);
    }

    /// Lists the versions of an annotation store.
    pub fn listAnnotationStoreVersions(self: *Self, allocator: std.mem.Allocator, input: list_annotation_store_versions.ListAnnotationStoreVersionsInput, options: list_annotation_store_versions.Options) !list_annotation_store_versions.ListAnnotationStoreVersionsOutput {
        return list_annotation_store_versions.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Retrieves a list of annotation stores.
    pub fn listAnnotationStores(self: *Self, allocator: std.mem.Allocator, input: list_annotation_stores.ListAnnotationStoresInput, options: list_annotation_stores.Options) !list_annotation_stores.ListAnnotationStoresOutput {
        return list_annotation_stores.execute(self, allocator, input, options);
    }

    /// Lists in-progress multipart read set uploads for a sequence store and
    /// returns it in a JSON formatted output. Multipart read set uploads are
    /// initiated by the `CreateMultipartReadSetUploads` API operation. This
    /// operation returns a response with no body when the upload is complete.
    pub fn listMultipartReadSetUploads(self: *Self, allocator: std.mem.Allocator, input: list_multipart_read_set_uploads.ListMultipartReadSetUploadsInput, options: list_multipart_read_set_uploads.Options) !list_multipart_read_set_uploads.ListMultipartReadSetUploadsOutput {
        return list_multipart_read_set_uploads.execute(self, allocator, input, options);
    }

    /// Retrieves a list of read set activation jobs and returns the metadata in a
    /// JSON formatted output. To extract metadata from a read set activation job,
    /// use the `GetReadSetActivationJob` API operation.
    pub fn listReadSetActivationJobs(self: *Self, allocator: std.mem.Allocator, input: list_read_set_activation_jobs.ListReadSetActivationJobsInput, options: list_read_set_activation_jobs.Options) !list_read_set_activation_jobs.ListReadSetActivationJobsOutput {
        return list_read_set_activation_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of read set export jobs in a JSON formatted response. This
    /// API operation is used to check the status of a read set export job initiated
    /// by the `StartReadSetExportJob` API operation.
    pub fn listReadSetExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_read_set_export_jobs.ListReadSetExportJobsInput, options: list_read_set_export_jobs.Options) !list_read_set_export_jobs.ListReadSetExportJobsOutput {
        return list_read_set_export_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of read set import jobs and returns the data in JSON
    /// format.
    pub fn listReadSetImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_read_set_import_jobs.ListReadSetImportJobsInput, options: list_read_set_import_jobs.Options) !list_read_set_import_jobs.ListReadSetImportJobsOutput {
        return list_read_set_import_jobs.execute(self, allocator, input, options);
    }

    /// Lists all parts in a multipart read set upload for a sequence store and
    /// returns the metadata in a JSON formatted output.
    pub fn listReadSetUploadParts(self: *Self, allocator: std.mem.Allocator, input: list_read_set_upload_parts.ListReadSetUploadPartsInput, options: list_read_set_upload_parts.Options) !list_read_set_upload_parts.ListReadSetUploadPartsOutput {
        return list_read_set_upload_parts.execute(self, allocator, input, options);
    }

    /// Retrieves a list of read sets from a sequence store ID and returns the
    /// metadata in JSON format.
    pub fn listReadSets(self: *Self, allocator: std.mem.Allocator, input: list_read_sets.ListReadSetsInput, options: list_read_sets.Options) !list_read_sets.ListReadSetsOutput {
        return list_read_sets.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata of one or more reference import jobs for a reference
    /// store.
    pub fn listReferenceImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_reference_import_jobs.ListReferenceImportJobsInput, options: list_reference_import_jobs.Options) !list_reference_import_jobs.ListReferenceImportJobsOutput {
        return list_reference_import_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of reference stores linked to your account and returns
    /// their metadata in JSON format.
    ///
    /// For more information, see [Creating a reference
    /// store](https://docs.aws.amazon.com/omics/latest/dev/create-reference-store.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn listReferenceStores(self: *Self, allocator: std.mem.Allocator, input: list_reference_stores.ListReferenceStoresInput, options: list_reference_stores.Options) !list_reference_stores.ListReferenceStoresOutput {
        return list_reference_stores.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata of one or more reference genomes in a reference
    /// store.
    ///
    /// For more information, see [Creating a reference
    /// store](https://docs.aws.amazon.com/omics/latest/dev/create-reference-store.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn listReferences(self: *Self, allocator: std.mem.Allocator, input: list_references.ListReferencesInput, options: list_references.Options) !list_references.ListReferencesOutput {
        return list_references.execute(self, allocator, input, options);
    }

    /// Retrieves a list of your run caches and the metadata for each cache.
    pub fn listRunCaches(self: *Self, allocator: std.mem.Allocator, input: list_run_caches.ListRunCachesInput, options: list_run_caches.Options) !list_run_caches.ListRunCachesOutput {
        return list_run_caches.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all run groups and returns the metadata for each run
    /// group.
    pub fn listRunGroups(self: *Self, allocator: std.mem.Allocator, input: list_run_groups.ListRunGroupsInput, options: list_run_groups.Options) !list_run_groups.ListRunGroupsOutput {
        return list_run_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of tasks and status information within their specified run.
    /// Use this operation to monitor runs and to identify which specific tasks have
    /// failed.
    pub fn listRunTasks(self: *Self, allocator: std.mem.Allocator, input: list_run_tasks.ListRunTasksInput, options: list_run_tasks.Options) !list_run_tasks.ListRunTasksOutput {
        return list_run_tasks.execute(self, allocator, input, options);
    }

    /// Retrieves a list of runs and returns each run's metadata and status.
    ///
    /// Amazon Web Services HealthOmics stores a configurable number of runs, as
    /// determined by service limits, that are available to the console and API. If
    /// the `ListRuns` response doesn't include specific runs that you expected, you
    /// can find all run logs in the CloudWatch logs. For more information about
    /// viewing the run logs, see [CloudWatch
    /// logs](https://docs.aws.amazon.com/omics/latest/dev/monitoring-cloudwatch-logs.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn listRuns(self: *Self, allocator: std.mem.Allocator, input: list_runs.ListRunsInput, options: list_runs.Options) !list_runs.ListRunsOutput {
        return list_runs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of sequence stores and returns each sequence store's
    /// metadata.
    ///
    /// For more information, see [Creating a HealthOmics sequence
    /// store](https://docs.aws.amazon.com/omics/latest/dev/create-sequence-store.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn listSequenceStores(self: *Self, allocator: std.mem.Allocator, input: list_sequence_stores.ListSequenceStoresInput, options: list_sequence_stores.Options) !list_sequence_stores.ListSequenceStoresOutput {
        return list_sequence_stores.execute(self, allocator, input, options);
    }

    /// Retrieves the resource shares associated with an account. Use the filter
    /// parameter to retrieve a specific subset of the shares.
    pub fn listShares(self: *Self, allocator: std.mem.Allocator, input: list_shares.ListSharesInput, options: list_shares.Options) !list_shares.ListSharesOutput {
        return list_shares.execute(self, allocator, input, options);
    }

    /// Retrieves a list of tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Retrieves a list of variant import jobs.
    pub fn listVariantImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_variant_import_jobs.ListVariantImportJobsInput, options: list_variant_import_jobs.Options) !list_variant_import_jobs.ListVariantImportJobsOutput {
        return list_variant_import_jobs.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Retrieves a list of variant stores.
    pub fn listVariantStores(self: *Self, allocator: std.mem.Allocator, input: list_variant_stores.ListVariantStoresInput, options: list_variant_stores.Options) !list_variant_stores.ListVariantStoresOutput {
        return list_variant_stores.execute(self, allocator, input, options);
    }

    /// Lists the workflow versions for the specified workflow. For more
    /// information, see [Workflow versioning in Amazon Web Services
    /// HealthOmics](https://docs.aws.amazon.com/omics/latest/dev/workflow-versions.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn listWorkflowVersions(self: *Self, allocator: std.mem.Allocator, input: list_workflow_versions.ListWorkflowVersionsInput, options: list_workflow_versions.Options) !list_workflow_versions.ListWorkflowVersionsOutput {
        return list_workflow_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of existing workflows. You can filter for specific
    /// workflows by their name and type. Using the type parameter, specify
    /// `PRIVATE` to retrieve a list of private workflows or specify `READY2RUN` for
    /// a list of all Ready2Run workflows. If you do not specify the type of
    /// workflow, this operation returns a list of existing workflows.
    pub fn listWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_workflows.ListWorkflowsInput, options: list_workflows.Options) !list_workflows.ListWorkflowsOutput {
        return list_workflows.execute(self, allocator, input, options);
    }

    /// Adds an access policy to the specified store.
    pub fn putS3AccessPolicy(self: *Self, allocator: std.mem.Allocator, input: put_s3_access_policy.PutS3AccessPolicyInput, options: put_s3_access_policy.Options) !put_s3_access_policy.PutS3AccessPolicyOutput {
        return put_s3_access_policy.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Starts an annotation import job.
    pub fn startAnnotationImportJob(self: *Self, allocator: std.mem.Allocator, input: start_annotation_import_job.StartAnnotationImportJobInput, options: start_annotation_import_job.Options) !start_annotation_import_job.StartAnnotationImportJobOutput {
        return start_annotation_import_job.execute(self, allocator, input, options);
    }

    /// Activates an archived read set and returns its metadata in a JSON formatted
    /// output. AWS HealthOmics automatically archives unused read sets after 30
    /// days. To monitor the status of your read set activation job, use the
    /// `GetReadSetActivationJob` operation.
    ///
    /// To learn more, see [Activating read
    /// sets](https://docs.aws.amazon.com/omics/latest/dev/activating-read-sets.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn startReadSetActivationJob(self: *Self, allocator: std.mem.Allocator, input: start_read_set_activation_job.StartReadSetActivationJobInput, options: start_read_set_activation_job.Options) !start_read_set_activation_job.StartReadSetActivationJobOutput {
        return start_read_set_activation_job.execute(self, allocator, input, options);
    }

    /// Starts a read set export job. When the export job is finished, the read set
    /// is exported to an Amazon S3 bucket which can be retrieved using the
    /// `GetReadSetExportJob` API operation.
    ///
    /// To monitor the status of the export job, use the `ListReadSetExportJobs` API
    /// operation.
    pub fn startReadSetExportJob(self: *Self, allocator: std.mem.Allocator, input: start_read_set_export_job.StartReadSetExportJobInput, options: start_read_set_export_job.Options) !start_read_set_export_job.StartReadSetExportJobOutput {
        return start_read_set_export_job.execute(self, allocator, input, options);
    }

    /// Imports a read set from the sequence store. Read set import jobs support a
    /// maximum of 100 read sets of different types. Monitor the progress of your
    /// read set import job by calling the `GetReadSetImportJob` API operation.
    pub fn startReadSetImportJob(self: *Self, allocator: std.mem.Allocator, input: start_read_set_import_job.StartReadSetImportJobInput, options: start_read_set_import_job.Options) !start_read_set_import_job.StartReadSetImportJobOutput {
        return start_read_set_import_job.execute(self, allocator, input, options);
    }

    /// Imports a reference genome from Amazon S3 into a specified reference store.
    /// You can have multiple reference genomes in a reference store. You can only
    /// import reference genomes one at a time into each reference store. Monitor
    /// the status of your reference import job by using the `GetReferenceImportJob`
    /// API operation.
    pub fn startReferenceImportJob(self: *Self, allocator: std.mem.Allocator, input: start_reference_import_job.StartReferenceImportJobInput, options: start_reference_import_job.Options) !start_reference_import_job.StartReferenceImportJobOutput {
        return start_reference_import_job.execute(self, allocator, input, options);
    }

    /// Starts a new run and returns details about the run, or duplicates an
    /// existing run. A run is a single invocation of a workflow. If you provide
    /// request IDs, Amazon Web Services HealthOmics identifies duplicate requests
    /// and starts the run only once. Monitor the progress of the run by calling the
    /// `GetRun` API operation.
    ///
    /// To start a new run, the following inputs are required:
    ///
    /// * A service role ARN (`roleArn`).
    /// * The run's workflow ID (`workflowId`, not the `uuid` or `runId`).
    /// * An Amazon S3 location (`outputUri`) where the run outputs will be saved.
    /// * All required workflow parameters (`parameter`), which can include optional
    ///   parameters from the parameter template. The run cannot include any
    ///   parameters that are not defined in the parameter template. To see all
    ///   possible parameters, use the `GetRun` API operation.
    /// * For runs with a `STATIC` (default) storage type, specify the required
    ///   storage capacity (in gibibytes). A storage capacity value is not required
    ///   for runs that use `DYNAMIC` storage.
    ///
    /// `StartRun` can also duplicate an existing run using the run's default
    /// values. You can modify these default values and/or add other optional
    /// inputs. To duplicate a run, the following inputs are required:
    ///
    /// * A service role ARN (`roleArn`).
    /// * The ID of the run to duplicate (`runId`).
    /// * An Amazon S3 location where the run outputs will be saved (`outputUri`).
    ///
    /// To learn more about the optional parameters for `StartRun`, see [Starting a
    /// run](https://docs.aws.amazon.com/omics/latest/dev/starting-a-run.html) in
    /// the *Amazon Web Services HealthOmics User Guide*.
    ///
    /// Use the `retentionMode` input to control how long the metadata for each run
    /// is stored in CloudWatch. There are two retention modes:
    ///
    /// * Specify `REMOVE` to automatically remove the oldest runs when you reach
    ///   the maximum service retention limit for runs. It is recommended that you
    ///   use the `REMOVE` mode to initiate major run requests so that your runs do
    ///   not fail when you reach the limit.
    /// * The `retentionMode` is set to the `RETAIN` mode by default, which allows
    ///   you to manually remove runs after reaching the maximum service retention
    ///   limit. Under this setting, you cannot create additional runs until you
    ///   remove the excess runs.
    ///
    /// To learn more about the retention modes, see [Run retention
    /// mode](https://docs.aws.amazon.com/omics/latest/dev/run-retention.html) in
    /// the *Amazon Web Services HealthOmics User Guide*.
    ///
    /// You can use Amazon Q CLI to analyze run logs and make performance
    /// optimization recommendations. To get started, see the [Amazon Web Services
    /// HealthOmics MCP
    /// server](https://github.com/awslabs/mcp/tree/main/src/aws-healthomics-mcp-server) on GitHub.
    pub fn startRun(self: *Self, allocator: std.mem.Allocator, input: start_run.StartRunInput, options: start_run.Options) !start_run.StartRunOutput {
        return start_run.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Starts a variant import job.
    pub fn startVariantImportJob(self: *Self, allocator: std.mem.Allocator, input: start_variant_import_job.StartVariantImportJobInput, options: start_variant_import_job.Options) !start_variant_import_job.StartVariantImportJobOutput {
        return start_variant_import_job.execute(self, allocator, input, options);
    }

    /// Tags a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Updates an annotation store.
    pub fn updateAnnotationStore(self: *Self, allocator: std.mem.Allocator, input: update_annotation_store.UpdateAnnotationStoreInput, options: update_annotation_store.Options) !update_annotation_store.UpdateAnnotationStoreOutput {
        return update_annotation_store.execute(self, allocator, input, options);
    }

    /// Updates the description of an annotation store version.
    pub fn updateAnnotationStoreVersion(self: *Self, allocator: std.mem.Allocator, input: update_annotation_store_version.UpdateAnnotationStoreVersionInput, options: update_annotation_store_version.Options) !update_annotation_store_version.UpdateAnnotationStoreVersionOutput {
        return update_annotation_store_version.execute(self, allocator, input, options);
    }

    /// Updates a run cache using its ID and returns a response with no body if the
    /// operation is successful. You can update the run cache description, name, or
    /// the default run cache behavior with `CACHE_ON_FAILURE` or `CACHE_ALWAYS`. To
    /// confirm that your run cache settings have been properly updated, use the
    /// `GetRunCache` API operation.
    ///
    /// For more information, see [How call caching
    /// works](https://docs.aws.amazon.com/omics/latest/dev/how-run-cache.html) in
    /// the *Amazon Web Services HealthOmics User Guide*.
    pub fn updateRunCache(self: *Self, allocator: std.mem.Allocator, input: update_run_cache.UpdateRunCacheInput, options: update_run_cache.Options) !update_run_cache.UpdateRunCacheOutput {
        return update_run_cache.execute(self, allocator, input, options);
    }

    /// Updates the settings of a run group and returns a response with no body if
    /// the operation is successful.
    ///
    /// You can update the following settings with `UpdateRunGroup`:
    ///
    /// * Maximum number of CPUs
    /// * Run time (measured in minutes)
    /// * Number of GPUs
    /// * Number of concurrent runs
    /// * Group name
    ///
    /// To confirm that the settings have been successfully updated, use the
    /// `ListRunGroups` or `GetRunGroup` API operations to verify that the desired
    /// changes have been made.
    pub fn updateRunGroup(self: *Self, allocator: std.mem.Allocator, input: update_run_group.UpdateRunGroupInput, options: update_run_group.Options) !update_run_group.UpdateRunGroupOutput {
        return update_run_group.execute(self, allocator, input, options);
    }

    /// Update one or more parameters for the sequence store.
    pub fn updateSequenceStore(self: *Self, allocator: std.mem.Allocator, input: update_sequence_store.UpdateSequenceStoreInput, options: update_sequence_store.Options) !update_sequence_store.UpdateSequenceStoreOutput {
        return update_sequence_store.execute(self, allocator, input, options);
    }

    /// Amazon Web Services HealthOmics variant stores and annotation stores will no
    /// longer be open to new customers starting November 7, 2025. If you would like
    /// to use variant stores or annotation stores, sign up prior to that date.
    /// Existing customers can continue to use the service as normal. For more
    /// information, see [ Amazon Web Services HealthOmics variant store and
    /// annotation store availability
    /// change](https://docs.aws.amazon.com/omics/latest/dev/variant-store-availability-change.html).
    ///
    /// Updates a variant store.
    pub fn updateVariantStore(self: *Self, allocator: std.mem.Allocator, input: update_variant_store.UpdateVariantStoreInput, options: update_variant_store.Options) !update_variant_store.UpdateVariantStoreOutput {
        return update_variant_store.execute(self, allocator, input, options);
    }

    /// Updates information about a workflow.
    ///
    /// You can update the following workflow information:
    ///
    /// * Name
    /// * Description
    /// * Default storage type
    /// * Default storage capacity (with workflow ID)
    ///
    /// This operation returns a response with no body if the operation is
    /// successful. You can check the workflow updates by calling the `GetWorkflow`
    /// API operation.
    ///
    /// For more information, see [Update a private
    /// workflow](https://docs.aws.amazon.com/omics/latest/dev/update-private-workflow.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn updateWorkflow(self: *Self, allocator: std.mem.Allocator, input: update_workflow.UpdateWorkflowInput, options: update_workflow.Options) !update_workflow.UpdateWorkflowOutput {
        return update_workflow.execute(self, allocator, input, options);
    }

    /// Updates information about the workflow version. For more information, see
    /// [Workflow versioning in Amazon Web Services
    /// HealthOmics](https://docs.aws.amazon.com/omics/latest/dev/workflow-versions.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn updateWorkflowVersion(self: *Self, allocator: std.mem.Allocator, input: update_workflow_version.UpdateWorkflowVersionInput, options: update_workflow_version.Options) !update_workflow_version.UpdateWorkflowVersionOutput {
        return update_workflow_version.execute(self, allocator, input, options);
    }

    /// Uploads a specific part of a read set into a sequence store. When you a
    /// upload a read set part with a part number that already exists, the new part
    /// replaces the existing one. This operation returns a JSON formatted response
    /// containing a string identifier that is used to confirm that parts are being
    /// added to the intended upload.
    ///
    /// For more information, see [Direct upload to a sequence
    /// store](https://docs.aws.amazon.com/omics/latest/dev/synchronous-uploads.html) in the *Amazon Web Services HealthOmics User Guide*.
    pub fn uploadReadSetPart(self: *Self, allocator: std.mem.Allocator, input: upload_read_set_part.UploadReadSetPartInput, options: upload_read_set_part.Options) !upload_read_set_part.UploadReadSetPartOutput {
        return upload_read_set_part.execute(self, allocator, input, options);
    }

    pub fn listAnnotationImportJobsPaginator(self: *Self, params: list_annotation_import_jobs.ListAnnotationImportJobsInput) paginator.ListAnnotationImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAnnotationStoreVersionsPaginator(self: *Self, params: list_annotation_store_versions.ListAnnotationStoreVersionsInput) paginator.ListAnnotationStoreVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAnnotationStoresPaginator(self: *Self, params: list_annotation_stores.ListAnnotationStoresInput) paginator.ListAnnotationStoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMultipartReadSetUploadsPaginator(self: *Self, params: list_multipart_read_set_uploads.ListMultipartReadSetUploadsInput) paginator.ListMultipartReadSetUploadsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReadSetActivationJobsPaginator(self: *Self, params: list_read_set_activation_jobs.ListReadSetActivationJobsInput) paginator.ListReadSetActivationJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReadSetExportJobsPaginator(self: *Self, params: list_read_set_export_jobs.ListReadSetExportJobsInput) paginator.ListReadSetExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReadSetImportJobsPaginator(self: *Self, params: list_read_set_import_jobs.ListReadSetImportJobsInput) paginator.ListReadSetImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReadSetUploadPartsPaginator(self: *Self, params: list_read_set_upload_parts.ListReadSetUploadPartsInput) paginator.ListReadSetUploadPartsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReadSetsPaginator(self: *Self, params: list_read_sets.ListReadSetsInput) paginator.ListReadSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReferenceImportJobsPaginator(self: *Self, params: list_reference_import_jobs.ListReferenceImportJobsInput) paginator.ListReferenceImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReferenceStoresPaginator(self: *Self, params: list_reference_stores.ListReferenceStoresInput) paginator.ListReferenceStoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReferencesPaginator(self: *Self, params: list_references.ListReferencesInput) paginator.ListReferencesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRunCachesPaginator(self: *Self, params: list_run_caches.ListRunCachesInput) paginator.ListRunCachesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRunGroupsPaginator(self: *Self, params: list_run_groups.ListRunGroupsInput) paginator.ListRunGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRunTasksPaginator(self: *Self, params: list_run_tasks.ListRunTasksInput) paginator.ListRunTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRunsPaginator(self: *Self, params: list_runs.ListRunsInput) paginator.ListRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSequenceStoresPaginator(self: *Self, params: list_sequence_stores.ListSequenceStoresInput) paginator.ListSequenceStoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSharesPaginator(self: *Self, params: list_shares.ListSharesInput) paginator.ListSharesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVariantImportJobsPaginator(self: *Self, params: list_variant_import_jobs.ListVariantImportJobsInput) paginator.ListVariantImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVariantStoresPaginator(self: *Self, params: list_variant_stores.ListVariantStoresInput) paginator.ListVariantStoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowVersionsPaginator(self: *Self, params: list_workflow_versions.ListWorkflowVersionsInput) paginator.ListWorkflowVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowsPaginator(self: *Self, params: list_workflows.ListWorkflowsInput) paginator.ListWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilAnnotationImportJobCreated(self: *Self, params: get_annotation_import_job.GetAnnotationImportJobInput) aws.waiter.WaiterError!void {
        var w = waiters.AnnotationImportJobCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilAnnotationStoreCreated(self: *Self, params: get_annotation_store.GetAnnotationStoreInput) aws.waiter.WaiterError!void {
        var w = waiters.AnnotationStoreCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilAnnotationStoreDeleted(self: *Self, params: get_annotation_store.GetAnnotationStoreInput) aws.waiter.WaiterError!void {
        var w = waiters.AnnotationStoreDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilAnnotationStoreVersionCreated(self: *Self, params: get_annotation_store_version.GetAnnotationStoreVersionInput) aws.waiter.WaiterError!void {
        var w = waiters.AnnotationStoreVersionCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilAnnotationStoreVersionDeleted(self: *Self, params: get_annotation_store_version.GetAnnotationStoreVersionInput) aws.waiter.WaiterError!void {
        var w = waiters.AnnotationStoreVersionDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilReadSetActivationJobCompleted(self: *Self, params: get_read_set_activation_job.GetReadSetActivationJobInput) aws.waiter.WaiterError!void {
        var w = waiters.ReadSetActivationJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilReadSetExportJobCompleted(self: *Self, params: get_read_set_export_job.GetReadSetExportJobInput) aws.waiter.WaiterError!void {
        var w = waiters.ReadSetExportJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilReadSetImportJobCompleted(self: *Self, params: get_read_set_import_job.GetReadSetImportJobInput) aws.waiter.WaiterError!void {
        var w = waiters.ReadSetImportJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilReferenceImportJobCompleted(self: *Self, params: get_reference_import_job.GetReferenceImportJobInput) aws.waiter.WaiterError!void {
        var w = waiters.ReferenceImportJobCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilRunCompleted(self: *Self, params: get_run.GetRunInput) aws.waiter.WaiterError!void {
        var w = waiters.RunCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilRunRunning(self: *Self, params: get_run.GetRunInput) aws.waiter.WaiterError!void {
        var w = waiters.RunRunningWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilTaskCompleted(self: *Self, params: get_run_task.GetRunTaskInput) aws.waiter.WaiterError!void {
        var w = waiters.TaskCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilTaskRunning(self: *Self, params: get_run_task.GetRunTaskInput) aws.waiter.WaiterError!void {
        var w = waiters.TaskRunningWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilVariantImportJobCreated(self: *Self, params: get_variant_import_job.GetVariantImportJobInput) aws.waiter.WaiterError!void {
        var w = waiters.VariantImportJobCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilVariantStoreCreated(self: *Self, params: get_variant_store.GetVariantStoreInput) aws.waiter.WaiterError!void {
        var w = waiters.VariantStoreCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilVariantStoreDeleted(self: *Self, params: get_variant_store.GetVariantStoreInput) aws.waiter.WaiterError!void {
        var w = waiters.VariantStoreDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilWorkflowActive(self: *Self, params: get_workflow.GetWorkflowInput) aws.waiter.WaiterError!void {
        var w = waiters.WorkflowActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilWorkflowVersionActive(self: *Self, params: get_workflow_version.GetWorkflowVersionInput) aws.waiter.WaiterError!void {
        var w = waiters.WorkflowVersionActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
