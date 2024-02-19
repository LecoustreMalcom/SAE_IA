import os
import shutil
import tkinter as tk
from tkinter import filedialog

def compress_to_love(directory, output_filename):
    # Assurez-vous que le nom de fichier de sortie se termine par .love
    if not output_filename.endswith('.love'):
        output_filename += '.love'

    # Utilisez shutil pour faire une archive zip
    shutil.make_archive(output_filename, 'zip', directory)

    # Renommez l'archive zip en .love
    os.rename(output_filename + '.zip', output_filename)

def select_directory():
    root = tk.Tk()
    root.withdraw()  # Hide the main window
    directory = filedialog.askdirectory()  # Show the dialog to choose directory
    compress_to_love(directory, 'jeu')  # Compress the chosen directory

select_directory()  
