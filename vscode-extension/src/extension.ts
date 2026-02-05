// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>

import * as path from 'path';
import * as vscode from 'vscode';
import {
  LanguageClient,
  LanguageClientOptions,
  ServerOptions,
  TransportKind
} from 'vscode-languageclient/node';

let client: LanguageClient;

export function activate(context: vscode.ExtensionContext) {
  // Server executable: mix run --no-halt from poly-container-lsp directory
  const serverCommand = 'mix';
  const serverArgs = ['run', '--no-halt'];

  const serverOptions: ServerOptions = {
    run: {
      command: serverCommand,
      args: serverArgs,
      transport: TransportKind.stdio,
      options: {
        // TODO: Set working directory to poly-container-lsp install location
        cwd: path.join(context.extensionPath, '../')
      }
    },
    debug: {
      command: serverCommand,
      args: serverArgs,
      transport: TransportKind.stdio,
      options: {
        cwd: path.join(context.extensionPath, '../')
      }
    }
  };

  const clientOptions: LanguageClientOptions = {
    documentSelector: [
      { scheme: 'file', language: 'dockerfile' },
      { scheme: 'file', pattern: '**/Dockerfile' },
      { scheme: 'file', pattern: '**/Containerfile' },
      { scheme: 'file', pattern: '**/docker-compose.yml' },
      { scheme: 'file', pattern: '**/compose.yml' }
    ],
    synchronize: {
      fileEvents: vscode.workspace.createFileSystemWatcher('**/{Dockerfile,Containerfile,*.yml}')
    }
  };

  client = new LanguageClient(
    'polyContainerLsp',
    'PolyContainer LSP',
    serverOptions,
    clientOptions
  );

  // Register commands
  context.subscriptions.push(
    vscode.commands.registerCommand('polyContainerLsp.runContainer', async () => {
      vscode.window.showInformationMessage('Run Container command (TODO)');
    })
  );

  context.subscriptions.push(
    vscode.commands.registerCommand('polyContainerLsp.buildImage', async () => {
      vscode.window.showInformationMessage('Build Image command (TODO)');
    })
  );

  context.subscriptions.push(
    vscode.commands.registerCommand('polyContainerLsp.inspectContainer', async () => {
      vscode.window.showInformationMessage('Inspect Container command (TODO)');
    })
  );

  context.subscriptions.push(
    vscode.commands.registerCommand('polyContainerLsp.viewLogs', async () => {
      vscode.window.showInformationMessage('View Logs command (TODO)');
    })
  );

  context.subscriptions.push(
    vscode.commands.registerCommand('polyContainerLsp.detectRuntimes', async () => {
      vscode.window.showInformationMessage('Detect Runtimes command (TODO)');
    })
  );

  client.start();
}

export function deactivate(): Thenable<void> | undefined {
  if (!client) {
    return undefined;
  }
  return client.stop();
}
