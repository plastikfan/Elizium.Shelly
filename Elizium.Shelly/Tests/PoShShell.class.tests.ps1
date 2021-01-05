
Import-Module .\Output\Elizium.Shelly\Elizium.Shelly.psm1
Describe 'PoShShell' {
  BeforeEach {
    InModuleScope Elizium.Shelly {
      [string]$script:_path = "$TestDrive\undo-script.ps1";
      [PoShShell]$script:_shell = [PoShShell]::new($_path);
    }
  }

  AfterEach {
    InModuleScope Elizium.Shelly {
      if (Test-Path -LiteralPath $_path) {
        Remove-Item -LiteralPath $_path;
      }
    }
  }

  Context 'given: multiple operations' {
    It 'should: build rename operation content' {
      InModuleScope Elizium.Shelly {
        $_shell.rename("$TestDrive\one.txt", 'one-new.txt');
        $_shell.rename("$TestDrive\two.txt", 'two-new.txt');
        $_shell.rename("$TestDrive\three.txt", 'three-new.txt');

        [string]$content = $_shell._builder.ToString();

        $content | Should -Match "one\.txt";
        $content | Should -Match "two\.txt";
        $content | Should -Match "three\.txt";
        $content | Should -Match "one-new\.txt";
        $content | Should -Match "two-new\.txt";
        $content | Should -Match "three-new\.txt";
      }
    }
  }
}
