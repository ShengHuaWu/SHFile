# SHFile
The main purpose of this project is to preserve files in the local temporary or documents directory.
However, _SHFile_ is an abstract class, please use its subclass instead.
There are two subclasses _SHTemporaryFile_ and _SHDocumentsFile_.

## Usage
The following example is related to _SHTemporaryFile_ class,
and the usage of _SHDocumentsFile_ is quite similar.

First of all, invoke the set-up method.

    [SHTemporaryFile setUp];

Create a file by a given name and data,
and save the file in the temporary directory.

    NSData *data = ...;
    SHTemporaryFile *file = [SHTemporaryFile fileWithName:@"filename.txt" data:data];
    NSError *error = nil;
    [file saveData:&error];

Delete the data in the temporary directory.

    [file deleteData:&error];

Clean up the temporary directory.

    [SHTemporaryFile cleanUp];

It's also possible to save or delete multiple files at once.

    NSArray *files = [self generateFiles]; // Generate multiple SHTemporaryFile instances.
    NSError *error = nil;
    [SHTemporaryFile saveAll:files error:&error];
