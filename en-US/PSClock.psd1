#localized string data for verbose messaging, errors, and warnings.

ConvertFrom-StringData @"
    SynchHash = Building a synchronized hashtable
    CantFind = Cant find a running PSClock. Do you need to start one?
    CreatingFlag = Creating the flag file {0}
    DefiningRunspace = Defining the runspace command
    DefiningWPF = Defining the WPF form and controls
    Detected = Detected PowerShell host: {0}
    Ending = Ending module command: {0}
    FlagFound = A running clock has been detected from another PowerShell session on this desktop: \n\n{0}\n\nIf this is incorrect, delete {1} and try again.
    Launching = Launching the runspace
    LoadingColor = Loading color values
    LoadingFont = Loading font families
    Measuring = Measuring primary display.
    RemovePrompt = Do you want to remove the flag file? Y/N
    Running = Running in PowerShell: {0}
    Saving = Saving PSClock settings to {0}
    Setting = Setting {0} to {1}
    Showing = Showing the WPF form
    Starting = Starting module command: {0}
    WarnDateFormat = The DateFormat value {0} is not a valid format string. Try something like F, G, or U, which are case-sensitive.
    Requires = This requires Windows PowerShell or PowerShell 7 on Windows.
    UsingText = Using sample text: {0}
    UsingImported = Using imported value for {0}
    UsingSaved = Using saved settings
    Validating = Validating clock parameter values
    RunningClock = You already have a clock running. You can only have one clock running at a time.
"@
