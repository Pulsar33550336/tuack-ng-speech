use tuack_plugin_sdk::{log::info, Document, Error, Processor, ProcessorOutput, processor};

struct ExampleProcessor;

impl Processor for ExampleProcessor {
    fn new() -> Self { ExampleProcessor }

    fn process(&self, doc: Document) -> Result<ProcessorOutput, Error> {
        info!("hello world");
        Ok(ProcessorOutput { ast: doc, warnings: Vec::new() })
    }
}

processor!(ExampleProcessor, process_example);
